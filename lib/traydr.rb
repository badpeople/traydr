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
end

