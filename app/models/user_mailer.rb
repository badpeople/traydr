class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    recipients user.email
    from APP_CONFIG[:email_server_outgoing_welcome_from_un] + "@" + APP_CONFIG[:email_server_outgoing_from_hostname]
    subject "Welcome to traydr.com"
    body :user => user , :hostname=>APP_CONFIG[:domain]
    content_type "text/html"
    
  end
  

end
