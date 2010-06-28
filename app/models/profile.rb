class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :last_name, :personal_blurb, :blog, :covestor, :stocktwits, :kaching, :style_blurb,:image_square,:image_small,:image_medium, :image_original

  before_save :htmlify

  def htmlify
    self.personal_blurb =  personal_blurb.gsub("\n","<br />") unless personal_blurb.nil?
    self.style_blurb= style_blurb.gsub("\n","<br />") unless style_blurb.nil?
  end
  
end
