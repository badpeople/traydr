class MailingsWorker < Workling::Base

  def send_mailing(options)
    begin
      AlertMailer.deliver_email(options[:email_package], options[:title], options[:body])
      puts "sending mailing: #{options.to_yaml}"
      
    rescue => e
      puts e.inspect
      puts e.backtrace
    end
  end

  def send_subscription_confirmation(options)
    begin
      puts "sending subscription notification: #{options.to_yaml}"
      UserMailer.deliver_subscription_confirmed(options)
    rescue => e
      puts e.inspect
      puts e.backtrace
    end
  end
  
end