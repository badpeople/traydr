module Traydr
  def sql_for_multiple_subscriptions(ids, my_table_name)
    ors = Array.new
    for id in ids
      ors.push(' system_id = ' + id.to_s )
    end
    where_clause = ors.join(' OR ')
    return 'select * from ' + my_table_name + ' where ' + where_clause
  end

  def save_picture
    @picture = Picture.new(params[:picture][:id], params[:picture][:file])
    resp = ""
    if @picture.save
      resp = 'and it\'s picture was successfully uploaded'
    else
      if Profile.find(params[:picture][:id]).image_square != nil
        resp = ''
      else
        if params[:picture][:file].class == StringIO
          resp = 'but you have not yet chosen a picture for it'
        else
          resp = 'but I could not upload the picture because it is not a valid Jpeg, Gif or Png file'
        end
      end
    end
    return resp
  end


  def range_rand(min, max)
    min + rand(max-min)
  end

#  def log_error(msg, e)
#    logger.error msg
#    logger.error e.to_s
#    logger.error e.backtrace
#  end

  def create_conf_code
    range_rand(100000000,999999999)
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


  def find_users_subscription(user_id, system_id)
    "select * from subscriptions where user_id = #{user_id} AND system_id = #{system_id}"
  end

  def default_keywords
    "financial newsletter marketplace trading systems "
  end

  def default_description
    "traydr.com - the financial newsletter marketplace : "
  end

  def seo_site?(hostname)
      !domain_map[hostname].nil?
  end

  def domain_map
    {
            "financialnewsletterreviews.com" =>{
                                                       :google_webmaster_code=>"sRqLZwvMgwgV8tSVeqBQz09Uk-ijEuV7HNbIdF6hjWg",
                                                       :google_analytics_code=>"UA-10324101-5",
                                                       :title=>"Financial Newsletter Reviews"
            },
            "freefinancialnewsletter.com" =>{:google_webmaster_code=>"UQCZ023HSC-bHq71nTAHCLQoP9HGiF-vorvAKciZMpw",
                                                    :google_analytics_code=>"UA-10324101-6",
                                                    :title=>"Free Financial Newsletters"
            },
            "topfinancialnewsletters.com" =>{:google_webmaster_code=>"bRUcg58iDuviCd8CfRE7W0urL5lzq5JKlfRwiJSGzL4",
                                                    :google_analytics_code=>"UA-10324101-8",
                                                    :title=>"Top Financial Newsletters"},
            "financialnewsletterratings.com" =>{:google_webmaster_code=>"FA5G6_u_XN-Q0QJKmVLHM3JpWBKG05ad2TZW_vM_D8w",
                                                       :google_analytics_code=>"UA-10324101-7",
                                                       :title=>"Financial Newsletter Ratings"
            },
            "financialnewsletterrankings.com" =>{:google_webmaster_code=>"K9CmAdsE7UTu_oMY1FVSZZbzGkR1RfkU9wIax4fpJAg",
                                                        :google_analytics_code=>"UA-10324101-9",
                                                        :title=>"Financial Newsletter Rankings"
            }
    }

  end

end

