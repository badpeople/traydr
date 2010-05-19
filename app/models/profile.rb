class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name, :personal_blurb, :blog, :covestor, :stocktwits, :kaching, :style_blurb
end
