class System < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions
  attr_accessible :name, :description, :price_email, :price_sms, :frequency_expected, :frequency_actual
  cattr_reader :per_page
  @@per_page = 8
end
