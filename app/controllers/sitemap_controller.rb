class SitemapController < ApplicationController

  def sitemap
    @entries = System.find(:all, :order => "updated_at DESC", :limit => 50000)
    @profiles = Profile.find(:all, :order => "updated_at DESC", :limit => 50000) 
    headers["Content-Type"] = "text/xml"
    # set last modified header to the date of the latest entry.
    headers["Last-Modified"] = @entries[0].updated_at.httpdate
    render :layout=>false
  end

end