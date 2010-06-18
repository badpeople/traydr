class System < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions
  attr_accessible :name, :description, :price_email, :price_sms, :frequency_expected, :frequency_actual,:extra_count
  cattr_reader :per_page
  before_save :htmlify_description

  @@per_page = 8

  has_many :reviews

  validates_numericality_of :price_email,:message=>"must be a number"
  validates_length_of :name, :minimum => 3, :too_short => " must be at least {{count}} letters long."

#  validate :must_be_friends
#
#  def must_be_friends
#    errors.add_to_base("Must be friends to leave a comment") unless commenter.friend_of?(commentee)
#  end


  def subscription_count
    return self.subscriptions.size() + self.extra_count
  end

  def htmlify_description
    self.description =  description.gsub("\n","<br />")
  end

  def average_rating
    reviews = Review.find_all_by_system_id(self.id)

    sum = 0
    if !reviews.nil? && reviews.size() > 0
      for review in reviews
        sum += review.primary_rating
      end
      (sum / reviews.size()).ceil
    else
      0
    end
  end


end
