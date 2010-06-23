class Emailalert < ActiveRecord::Base
  belongs_to :system
  attr_accessible :title, :body, :send_at

  before_save :htmlify_body

  def htmlify_body
    self.body =  body.gsub("\n","<br />")
  end


  def find_by_multiple_subscriptions(ids)
    return self.find_by_sql(sql_for_multiple_subscriptions(ids,table_name))
  end
end