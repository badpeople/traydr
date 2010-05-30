class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name, :personal_blurb, :blog, :covestor, :stocktwits, :kaching, :style_blurb,:image_square,:image_small,:image_medium, :image_original

  
end
