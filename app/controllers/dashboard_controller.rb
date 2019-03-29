class DashboardController < ApplicationController  
  before_action :authenticate_user!
  layout 'dashboard'
  
  def index
    @user = current_user
    
    if params[:profile] != nil
      if params[:type] == 'location'
        @profile = Location.find(params[:profile])
        @type = 'location'
      else
        @profile = Performer.find(params[:profile])
        @type = 'performer'
      end
    else 
      if @user.locations.any? 
        @profile = @user.locations.first
        @type = 'location'
      else 
        @profile = @user.performers.first
        @type = 'performer'
      end
    end
  end
  
  def new_location
    @user = current_user
    @location = Location.new
    @resource = "Ihre Location"
  end
  
  def new_performer
    @user = current_user
    @performer = Performer.new
    @resource = "Ihr Performer"
  end
  
  def new_event
    @user = current_user
    @event = Event.new
    @resource = "Ihre Veranstaltung"
  end
  
  def edit_event
    @event = Event.find(params[:id])
  end
  
  def edit_performer
    @performer = Performer.find(params[:id])
  end
  
  def show_location
    @profile = Location.find(params[:id])
    
    respond_to do |format|
      format.js { render partial: 'dashboard/shared/show_location' }
    end
  end
  
  def show_performer
    @profile = Performer.find(params[:id])
    
    respond_to do |format|
      format.js { render partial: 'dashboard/shared/show_performer' }
    end
  end
  
  def settings
    @user = current_user
  end
  
  def delete_image
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    respond_to do |format|
      format.js { render partial: 'dashboard/shared/image_destroyed' }
    end
  end
  
private
  
  
end
