class UserMailer < ActionMailer::Base

  default from: "notifications@g2-store.com"

  def welcome_email(new_user)
    mail(to: new_user.email, subject: "Thank you for signing up!")
  end
end