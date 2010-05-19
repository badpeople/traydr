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

#  def log_error(msg, e)
#    logger.error msg
#    logger.error e.to_s
#    logger.error e.backtrace
#  end
end

