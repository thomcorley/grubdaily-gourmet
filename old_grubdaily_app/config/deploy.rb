# Change these
server '134.122.108.115', port: 22, roles: [:web, :app], primary: true

set :repo_url,        'git@github.com:thomcorley/grubdaily.git'
set :application,     'grubdaily'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_access_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :rvm_ruby_version, "ruby-2.7.1"
set :default_env, { rvm_bin_path: "~/.rvm/bin/rvm" }
set :puma_enable_socket_service, true
set :rvm_map_bins, %w{gem rake ruby rails bundle puma pumactl}

## Defaults:
set :format,        :pretty
set :log_level,     :debug
set :keep_releases, 5

## Linked Files & Directories (Default None):
append :linked_files, 'config/master.key'
append :linked_dirs,  'bin' 'log' 'tmp/pids' 'tmp/cache' 'tmp/sockets' 'vendor/bundle' 'public/system'

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
        puts "WARNING: HEAD is not the same as origin/#{fetch(:branch)}"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
      Rake::Task['puma:restart'].reenable
    end
  end

  before :starting,   :check_revision
  after  :publishing, :restart
  before :finishing,  :restart
  after  :finishing,  :cleanup
  after  :finishing,  :compile_assets
  after  :rollback,   :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
