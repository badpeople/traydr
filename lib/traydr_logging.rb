module TraydrLogging
  include Rails
  def log(msg, e)
    RAILS_DEFAULT_LOGGER.error msg unless msg.nil?
    unless e.nil? 
      RAILS_DEFAULT_LOGGER.error e.inspect
      RAILS_DEFAULT_LOGGER.error e.backtrace.join("\n")
    end
  end


end

