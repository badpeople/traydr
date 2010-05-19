class SmsalertsController < ApplicationController
  def index
    @smsalerts = Smsalert.all
  end
  
  def show
    @smsalert = Smsalert.find(params[:id])
  end
  
  def new
    @smsalert = Smsalert.new
  end
  
  def create
    @smsalert = Smsalert.new(params[:smsalert])
    @smsalert.system = System.find(params[:smsalert][:system_id])

    if @smsalert.save
      flash[:notice] = "Successfully created SMS alert."
      redirect_to @smsalert
    else
      render :action => 'new'
    end
  end
  
  def edit
    @smsalert = Smsalert.find(params[:id])
  end
  
  def update
    @smsalert = Smsalert.find(params[:id])
    if @smsalert.update_attributes(params[:smsalert])
      flash[:notice] = "Successfully updated smsalert."
      redirect_to @smsalert
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @smsalert = Smsalert.find(params[:id])
    @smsalert.destroy
    flash[:notice] = "Successfully destroyed smsalert."
    redirect_to smsalerts_url
  end
end
