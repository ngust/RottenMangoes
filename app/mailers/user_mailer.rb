class UserMailer < ActionMailer::Base
  default from: "nicholasgust@gmail.com"

  # def welcome_email(user)
  #   @user = user
  #   @url  = 'http://example.com/login'
  #   mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  # end

  def delete_email(user)
    @user = user
    @url  = 'http://rottenmangoes.com'
    mail(to: @user.email, subject: 'You are the weakest link, goodbye.')
  end
end
