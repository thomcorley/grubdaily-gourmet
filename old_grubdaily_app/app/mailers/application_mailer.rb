class ApplicationMailer < ActionMailer::Base
  ADMIN_EMAIL_ADDRESS = "tom@grubdaily.com"
  ADMIN_EMAIL_ADDRESS_DEV = "thomcorley+grubdaily@gmail.com"

  default from: "from@example.com"
  layout "mailer"
end
