class PublicViewController < ApplicationController
  
  def location     
    @resource = Location.find_by_path(params[:path])    
    @day = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
    
    @title = @resource.name
    @image = url_for(@resource.images.first)
    @description = @resource.description
    @type = "Location"
  end

  def event
    @resource = Event.find_by_path(params[:path])
    
    @title = @resource.name
    @image = url_for(@resource.images.first)
    @description = @resource.description
    @type = "Event"
  end

  def performer
    @resource = Performer.find_by_path(params[:path])
    
    @title = @resource.name
    @image = url_for(@resource.profile_image)
    @description = @resource.description
    @type = "Performer"
  end
  
  def tickets
    @resource = Event.find_by_path(params[:path]).tickets
    
    @title = @resource.event.name
    @image = url_for(@resource.event.images.first)
    @description = "Ticketinformationen für " + @resource.event.name
  end
  
  private
  
  
end
