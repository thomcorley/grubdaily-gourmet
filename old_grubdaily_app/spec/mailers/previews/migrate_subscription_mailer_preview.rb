# Preview all emails at http://localhost:2020/rails/mailers/recipe_mailer
class MigrateSubscriptionMailerPreview < ActionMailer::Preview
  def migrate
    MigrateSubscriptionMailer.migrate(["thomcorley@gmail.com"])
  end
end
