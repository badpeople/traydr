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
  
end