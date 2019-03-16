class DashboardController < ApplicationController
  before_action :authenticate_user!
  
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
  
  def settings
    @user = current_user
  end
  
private
  
  
end
