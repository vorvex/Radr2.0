class DashboardController < ApplicationController

  
  def index
    @user = current_user
  end
  
  def new_location
    @user = current_user
    @location = Location.new
  end
  
  def new_performer
    @user = current_user
    @performer = Performer.new
  end
  
  def new_event
    @user = current_user
    @event = Event.new
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
