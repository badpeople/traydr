class Post < ActiveRecord::Base

  belongs_to :user
  attr_accessible :title, :text, :path


end
