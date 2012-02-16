class UserMailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #
  def confirm(user,sent_at = Time.now)
    @user = user
    @url = activate_url(:token => user.activation_token)
    mail(:to => user.email, :subject => 'Activation Email', :from => 'jiasilu1987@gmail.com', :sent_on => sent_at)
    
  end
end

