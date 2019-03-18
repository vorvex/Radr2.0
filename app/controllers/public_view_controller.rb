class PublicViewController < ApplicationController
  def location
    @resource = Location.where('locality = ?', params[:city]).find_by_name(params[:name])    
    @day = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
  end

  def event
    @event = Event.find_by_name(params[:name])
  end

  def performer
    @performer = Performer.find(params[:id])
  end
  
  private
  
  
end
