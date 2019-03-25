class DashboardController < ApplicationController  
  layout 'dashboard'
  
  def index
    @user = current_user
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
    @user = User.first
    @event = Event.new
    @resource = "Ihre Veranstaltung"
  end
  
  def edit_event
    @event = Event.find(params[:id])
  end
  
  def edit_performer
    @performer = Performer.find(params[:id])
  end
  
  def settings
    @user = current_user
  end
  
private
  
  
end
