# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def medium_profile_image(profile)
    if profile.image_medium.nil?
      return image_tag("man_silhouette_medium.png",:width=>180)
    end
    return image_tag(profile.image_medium,:width=>180)
  end

  def profile_link(user)
    return link_to user.username,:controller=>"profiles",:action=>"show_by_user",:id=>user
  end

  def price_display(price)
    if price == 0
      return "FREE"
    else
      number_to_currency(price)
    end
  end

  def isEmptyString?(str)
    return true unless !str.nil?
    return true unless str.length > 0
    false
  end

  def unhtmlify_description(description)
    return description.gsub("<br />","\n") unless description.nil?
    return ""

  end

  def paypal_price_format(price)
    return number_to_currency(price,:precision=>2,:unit=>"",:delimiter=>"")
  end


  def status_new
    "NEW"
  end
  def status_confirmed
    "CONFIRMED"
  end
  def status_unconfirmed
    "UNCONFIRMED"
  end
end
