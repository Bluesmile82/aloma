class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.booking_confirmation.subject
  #

default from: 'haunted@yopmail.com'

  def booking_confirmation
    @user = user
    @booking = booking
    mail (to: @user.email, subject: 'You are about to be terrified')
  end
end
