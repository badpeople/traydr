class AlertMailer < ActionMailer::Base

  def email(email_package, title, body)
    begin
      recipients email_package[:email]
      from APP_CONFIG[:email_server_outgoing_alert_from_un] + "@" + APP_CONFIG[:email_server_outgoing_from_hostname]
      subjectStr = "TRAYDR.COM:ALERT from #{email_package[:system_username]}'s  #{email_package[:system_name]} system: #{title}"
      subject  subjectStr
      content_type "text/html"
      body render_message("email",:body => body, :title=>title,:email_package=>email_package,  :hostname=>APP_CONFIG[:domain])
    rescue => e
      logger.error "error generating email"
      logger.error e.inspect
      logger.error e.backtrace
    end
  end

end
