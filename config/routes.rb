Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "hello#home"

  devise_for :users
  get "login", to: redirect("users/sign_in")
  get "logout", to: redirect("users/sign_out")
  get "signup", to: redirect("users/sign_up")
  get "qrcode", to: redirect("/")

  # Recipe Imports
  get "recipe_imports/new" => "recipe_imports#new"
  get "new_recipe" => "recipe_imports#new"
  post "recipe_imports/create" => "recipe_imports#create"
  get "recipe_imports/show" => "recipe_imports#show"
  resources :recipe_imports

  get "generate_jekyll_post" => "jekyll_posts#generate"
  get "touch_ingredient_entry/:id", to: "ingredient_entries#touch", as: "touch_ingredient_entry"

  # Home
  get "about" => "home#about"
  get "recipe-index" => "home#recipe_index"
  get "latest-entry" => "home#latest_entry"
  get "shop" => "home#shop"
  get "test" => "home#test"

  get "more_recipes" => "home#more_recipes" # AJAX path

  # API
  constraints subdomain: 'api' do
    namespace :api, path: '' do
      get "/recipes" => "recipes#index"
      get "/search" => "recipes#search"
      get "/sample" => "recipes#sample"
    end
  end

  # Attachments
  resources :attachments, only: [:edit, :update] do
    member do
      get "/delete" => "api/attachments#destroy"
    end
  end

  # Orders
  get "menu" => "orders#new"
  resources :orders

  # Blog Posts
  resources :blog_posts, path: 'blog-posts' do
    collection do
      get "publish"
      get "unpublish"
      get "feed", format: "rss"
    end
  end

  get "blog-post-index", to: redirect("blog-posts")
  get "more_blog_posts", to: "blog_posts#more_blog_posts" # AJAX path

  # Recipes
  resources :recipes do
    collection do
      get "publish"
      get "unpublish"
      get "feed", format: "rss"
    end

    member do
      get :as_yaml
    end

    resources :method_steps

    resources :ingredient_sets do
      resources :ingredient_entries
    end
  end

  # Ingredients
  resources :ingredients do
    member do
      get "publish"
      get "unpublish"
    end
  end

  # Digested Reads
  resources :digested_reads do
    collection do
      get "feed", format: "rss"
    end
  end

  # Contact Form Messages
  resources :contact_form_messages
  get "contact_form/confirmation" => "contact_form_messages#confirmation"

  # Email Subscribers
  resources :email_subscribers do
    collection do
      get "send_confirmation"
      get "subscription_confirmed"
    end
  end

  # Collections
  resources :collections

  # Image Uploads
  resources :image_uploads do
    member do
      get :as_yaml
    end
  end

  get "/entries/autocomplete", to: "entries#autocomplete"

  # Search
  get "/search", to: "search#search"

  # Tags
  get "tags/mushroom", to: redirect("tags/mushrooms")
  get "/tags/:tag_name", to: "tags#show", as: "tag"

  # Sitemap
  get "sitemap.xml" => "sitemap#show", format: "rss"

  # Priority redirects
  #
  # These have to be defined before the dynamic recipe path otherwise they'll be processed
  # automatically by the RecipesController.
  get "/peanutcaramel", to: redirect("collections/peanut-caramel-recipes")
  get "/sourdough", to: redirect("/posts/sourdough")
  get "/mushroompowder", to: redirect("collections/mushroom-powder-recipes")
  get "/recipe_index", to: redirect("recipe-index")
  get "/photos", to: redirect("recipe-index")
  get "blog-posts", to: "blog_posts#index"

  # Redirects
  get "/chocolate/chocolate_mousse", to: redirect("chocolate-mousse")
  get "/soup/chicken_and_coriander_broth", to: redirect("chicken-coriander-broth")
  get "/dessert/peanut_caramel_cheesecake", to: redirect("peanut-caramel-cheesecake")
  get "/fish/cod_with_cockles_a_la_creme", to: redirect("cod-cockles-creme")
  get "/pork/pork_belly_asparagus_and_ale_sauce", to: redirect("pork-belly-asparagus-ale-sauce")
  get "/blog/barley-risotto-with-chicken", to: redirect("barley-risotto-chicken")
  get "/blog/salmon-and-hollandaise", to: redirect("salmon-hollandaise")
  get "/blog/confit-duck", to: redirect("duck-rilettes")
  get "/2011/09/peanut-butter-and-jam-creme-brulee", to: redirect("peanut-butter-jam-creme-brulee")
  get "/2011/09/peanut-butter-millionaire-shortbread", to: redirect("peanut-butter-caramel-shortbread")
  get "/ricotta", to: redirect("homemade-ricotta")
  get "/pasta_puttanesca", to: redirect("pasta-puttanesca")
  get "/peanut-butter-jam-creme-brulee", to: redirect("peanut-caramel-jam-creme-brulee")
  get "/peanut-butter-caramel-shortbread", to: redirect("peanut-caramel-shortbread")

  # Dynamic paths
  get "/:recipe_path" => "recipes#show", as: 'friendly_recipe'
  get "/posts/:blog_post_path" => "blog_posts#show", as: 'frienldly_blog_post'
  get "/digested/:digested_read_path" => "digested_reads#show", as: 'friendly_digested_read'
  get "/ingredient/:ingredient_path", to: "ingredients#show", as: 'friendly_ingredient'
  get "/collection/:collection_path", to: "collections#show", as: "friendly_collection"
  get "/images/:image_upload_path", to: "image_uploads#show", as: "friendly_image_upload"

  # CDN routes
  direct :cdn_image do |model|
    if model.is_a?(String) && model =~ /placeholder.jpg/
      model
    elsif model.respond_to?(:signed_id)
      route_for(
        :rails_service_blob_proxy,
        model.signed_id,
        model.filename,
        host: Rails.configuration.active_storage.cdn_host || ENV['CDN_HOST'] || Rails.configuration.active_storage.host || Rails.application.default_url_options[:host]
      )
    else
      signed_blob_id = model.blob.signed_id
      variation_key  = model.variation.key
      filename       = model.blob.filename

      route_for(
        :rails_blob_representation_proxy,
        signed_blob_id,
        variation_key,
        filename,
        host: Rails.configuration.active_storage.cdn_host || ENV['CDN_HOST'] || Rails.configuration.active_storage.host || Rails.application.default_url_options[:host]
      )
    end
  end

  root :to => "home#index"

end
