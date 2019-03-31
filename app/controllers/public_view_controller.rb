class PublicViewController < ApplicationController
  
  def location
    @resource = Location.find_by_path(params[:path])    
    @day = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
  end

  def event
    @resource = Event.find_by_path(params[:path])
  end

  def performer
    @resource = Performer.find_by_path(params[:path])
  end
  
  def tickets
    @resource = Event.find_by_path(params[:path]).tickets
  end
  
  private
  
  
end
