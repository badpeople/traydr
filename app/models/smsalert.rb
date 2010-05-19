class Smsalert < ActiveRecord::Base
  belongs_to :system
  attr_accessible :message, :send_at

  def table_name
    return 'smsalerts'
  end
end