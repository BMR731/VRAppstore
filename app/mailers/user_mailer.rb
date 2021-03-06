class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_token.subject
  #
  def activation_token(user)
    @greeting = "Hi"
    @user = user
    mail to: user.email ,subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
