class System < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions
  attr_accessible :name, :description, :price_email, :price_sms, :frequency_expected, :frequency_actual,:extra_count
  cattr_reader :per_page
  before_save :htmlify_description

  has_many :reviews

  @@per_page = 8

  def subscription_count
    return self.subscriptions.size() + self.extra_count
  end

  def htmlify_description
    self.description =  description.gsub("\n","<br />")
  end




end
