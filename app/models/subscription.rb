class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :system
  attr_accessible :to_email, :to_sms
end