class PublicViewController < ApplicationController
  def location
    @resource = Location.where('locality = ?', params[:city]).find_by_name(params[:name])    
    @day = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
  end

  def event
    @resource = Event.find(params[:id])
  end

  def performer
    @resource = Performer.find(params[:id])
  end
  
  def tickets
    @resource = Event.find(params[:id]).tickets
  end
  
  private
  
  
end
