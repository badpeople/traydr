class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    recipients user.email
    from APP_CONFIG[:email_server_outgoing_welcome_from_un] + "@" + APP_CONFIG[:email_server_outgoing_from_hostname]
    subject "Welcome to traydr.com"
    body :user => user , :hostname=>APP_CONFIG[:domain]
    content_type "text/html"
    
  end

  def subscription_confirmed(options)
    begin
      logger.debug "sending email to #{options[:email]}"
      recipients options[:email]
      from APP_CONFIG[:email_server_outgoing_alert_from_un] + "@" + APP_CONFIG[:email_server_outgoing_from_hostname]
      subject "TRAYDR.COM: You have a new subscriber to '#{options[:system_name]}'"
      content_type "text/html"

      body render_message("subscription_confirmation",:options=>options)

    rescue => e
       logger.error "error generating subscription confirmed email"
      logger.error e.inspect
      logger.error e.backtrace
    end

  end

  def review_creation(options)
    begin
      logger.debug "sending REVIEW CREATED email to #{options[:email]}"
      recipients options[:email]
      from APP_CONFIG[:email_server_outgoing_alert_from_un] + "@" + APP_CONFIG[:email_server_outgoing_from_hostname]
      subject "TRAYDR.COM: You have a new review for '#{options[:system_name]}'"
      content_type "text/html"

      body render_message("review_creation",:options=>options)

    rescue => e
      logger.error "error generating review creation email"
      logger.error e.inspect
      logger.error e.backtrace
    end

  end

end
