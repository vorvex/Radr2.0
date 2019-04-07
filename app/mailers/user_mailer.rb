class UserMailer < ApplicationMailer
  default from: 'do-not-reply@the-radr.com'
 
  def invoice_email
    @user = params[:user]
    @invoice = params[:invoice]
    mail(to: @user.email, subject: 'Willkommen bei Radr')
  end  
  
end