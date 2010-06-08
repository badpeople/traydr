class Review < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :system

  attr_accessible :text,:primary_rating

end