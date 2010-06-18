class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :system
  attr_accessible :to_email, :to_sms, :paypal_payer_email, :paypal_subscr_id, :paypal_payer_id, :status

  

end