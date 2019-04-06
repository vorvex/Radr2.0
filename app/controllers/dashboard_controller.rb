class DashboardController < ApplicationController  
  before_action :authenticate_user!
  layout 'dashboard'
  
  def first_login
    
  end
  
  def first_event
    
  end
  
  def index
    finish_onboarding
    onboarding_done?
    
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
  
  def profiles
    @user = current_user
    
  end
  
  def abo
    @user = current_user    
  end
  
private
  
  def has_profile?
    if !current_user.locations.any? && !current_user.performers.any?
      redirect_to first_login_path
    end
  end
  
  def finish_onboarding
    if params[:onboardingfinished]
      current_user.onboarding = true
      current_user.save!
    end
  end
  
  def onboarding_done?
    if !current_user.locations.any? && !current_user.performers.any?      
      redirect_to first_login_path
      return
    else
      if current_user.onboarding != true
        if current_user.events.length == 0
          redirect_to first_event_path
        else
          redirect_to select_abo_path
        end
      end
    end
  end
  
end
