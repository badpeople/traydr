# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def small_profile_image(profile)
    return image_tag("profiles/#{profile.id}/#{profile.id}_small.jpg",:width=>180)
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
end
