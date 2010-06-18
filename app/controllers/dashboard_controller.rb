class DashboardController < ApplicationController
#  before_filter :login_required
  def systems_alerts
     
  end

  def alerts
    @subscriptions = Subscription.find_all_by_user_id(current_user.id)
    subscription_ids = Array.new
    for subscription in @subscriptions
      subscription_ids.push(subscription.system_id)
    end

    @emailalerts = Emailalert.find_by_sql(sql_for_multiple_subscriptions(subscription_ids,Emailalert.table_name))
    @smsalerts = Smsalert.find_by_sql(sql_for_multiple_subscriptions(subscription_ids,Smsalert.table_name))
  end

  def contact
    @content_for_title = "Contact"

  end

  def unconfirmed
    if logged_in?
      @user = current_user
    else
      redirect_to root_url
    end
  end

  def faq
     @content_for_title = "frequently asked questions"
  end

  def disclaimer

  end

end
