class EventController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'dashboard'
  
  def create_event1 # Name, Category, Start & Endtime
    Time.zone = "Berlin"
    name = params[:eventname]
    location = Location.find(params[:event][:location_id])
    startTime = params[:event][:start_date] + " " + params[:event][:start_time]
    endTime = params[:event][:end_date] + " " + params[:event][:end_time]
    
    path = (location.locality + " " + name).downcase.gsub(" ", "-")
    x = 0
    while !Event.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    
    @event = Event.new(location: location, name: name, path: path)
    
    @event.start_time = Time.zone.strptime(startTime, "%d.%m.%Y %H:%M")
    if endTime != " "
      @event.end_time = Time.zone.strptime(endTime, "%d.%m.%Y %H:%M")
    end
    @event.save
    respond_to do |format|
      format.js { render partial: 'event/success1' }
    end
    
  end
  
  def add_images # Bilder
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    if params[:id] == 0
      @event = Event.last
    else
      @event = Event.find(params[:id])
    end
    
    image = params[:file]
    
     if !@event.images_thumbnail.attached? 
       
      thumbnail = File.basename(image.original_filename, File.extname(image.original_filename)) + '-thumbnail' + File.extname(image.original_filename)

      source_thumbnail = Tinify.from_file(image.tempfile)
      resized_thumbnail = source_thumbnail.resize(
        method: "cover",
        width: 280,
        height: 160
      )
       resized_thumbnail.to_file('/tmp/' + thumbnail)
       @event.images_thumbnail.attach(io: File.open('/tmp/' + thumbnail), filename: thumbnail)
       
     end
      
        source = Tinify.from_file(image.tempfile)
        resized = source.resize(
          method: "cover",
          width: 750,
          height: 440
        )

        resized.to_file('/tmp/' + image.original_filename)

        @event.images.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)
    
  end
  
  def search_performer 
    @search = params[:q].downcase
    if @search != ""
      @performer = Performer.where('lower(name) LIKE ?', "%#{@search}%").limit(5)
    else
      @performer = Performer.none
    end
    respond_to do |format|
      format.js { render partial: 'event/performersearch' }
    end
  end
  
  def invite_performer
    @performer = Performer.create(name: params[:performer][:name], email: params[:performer][:email], category: params[:performer][:category])
    
    # Send Email to Performer 
    
    respond_to do |format|
      format.js { render partial: 'event/performersuccess' }
    end
  end
  
  def create_event3 # Beschreibung & Öffnungszeiten
    @event = Event.find(params[:id])    

    @event.update(description: params[:description], category: params[:event][:category], performer_id: params[:performer_id])   
    
    @event.save
    
    respond_to do |format|
      format.js { render partial: 'event/success3' }
    end
  end
  
  def create_event4 #Tickets & Social Links
    @event = Event.find(params[:id])  
    
    
  end

  def share #Tickets & Social Links
    @resource = Event.find(params[:id])  
  end
  
  def edit_images
    @event = Event.find(params[:id])
  end
  
  def edit
    @event = Event.find(params[:id])
    @start_date = @event.start_time.month.to_s.rjust(2, '0') + "." + @event.start_time.month.to_s.rjust(2, '0') + "." + @event.start_time.year.to_s
    @end_date = @event.end_time.month.to_s.rjust(2, '0') + "." + @event.end_time.month.to_s.rjust(2, '0') + "." + @event.end_time.year.to_s
  end
  
  def update
    @event = Event.find(params[:id])
    name = params[:event][:name]
    location = Location.find(params[:event][:location_id])
    startTime = params[:event][:start_date] + " " + params[:event][:start_time]
    endTime = params[:event][:end_date] + " " + params[:event][:end_time]
    
    path = (location.locality + " " + name).downcase.gsub(" ", "-")
    x = 0
    while !Event.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    
    @event.start_time = Time.zone.strptime(startTime, "%d.%m.%Y %H:%M")
    if endTime != " "
      @event.end_time = Time.zone.strptime(endTime, "%d.%m.%Y %H:%M")
    end
    
    @event.update(name: name , description: params[:description], category: params[:event][:category], location_id: location.id, path: path )
    @event.save

  end
  
  def delete
  end
  
  private
  
  def event_params
    params.require(:event).permit(:location_id, :performer_id, :name, :category, :description, :start_time, :end_time, :pathname, :facebook_event, :image_url, :start_date, :end_date, :soundcloud, :status)
  end
  
end
