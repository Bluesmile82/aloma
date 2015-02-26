class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.booking_confirmation.subject
  #

default from: 'haunted@yopmail.com'

  def booking_confirmation(hash)
    @user = hash[:user]
    @booking = hash[:booking]
    @flat = hash[:flat]
    # @user.email = 'haunted@yopmail.com'
    mail(to: @user.email, subject: 'You are about to be terrified')

  end
end
