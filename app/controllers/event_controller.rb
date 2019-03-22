class EventController < ApplicationController
  def create_event1 # Name, Category, Start & Endtime
    Time.zone = "Berlin"
    name = params[:eventname]
    location = Location.find(params[:event][:location_id])
    startTime = params[:event][:start_date] + " " + params[:event][:start_time]
    endTime = params[:event][:end_date] + " " + params[:event][:end_time]
    
    @event = Event.new(location: location, name: name)
    
    @event.start_time = Time.zone.strptime(startTime, "%m/%d/%Y %H:%M")
    if endTime != " "
      @event.end_time = Time.zone.strptime(endTime, "%m/%d/%Y %H:%M")
    end
    @event.save
    respond_to do |format|
      format.js { render partial: 'event/success1' }
    end
    
  end
  
  def create_event2 # Bilder
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    
    @event = Event.find(params[:id])
    
    images = params[:event][:attachment]
    
    if images != nil
    
      thumbnail = File.basename(images.first.original_filename, File.extname(images.first.original_filename)) + '-thumbnail' + File.extname(images.first.original_filename)

      source_thumbnail = Tinify.from_file(images.first.tempfile)
      resized_thumbnail = source_thumbnail.resize(
        method: "cover",
        width: 280,
        height: 160
      )
      images.each do |image| 
        source = Tinify.from_file(image.tempfile)
        resized = source.resize(
          method: "cover",
          width: 750,
          height: 440
        )

        resized.to_file('/tmp/' + image.original_filename)
        resized_thumbnail.to_file('/tmp/' + thumbnail)

        @event.images.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)
      end    
      @event.images_thumbnail.attach(io: File.open('/tmp/' + thumbnail), filename: thumbnail)
    
    end  
    if @event.thumbnail.attached?
      respond_to do |format|
        format.js { render partial: 'event/success2' }
      end
    else
      respond_to do |format|
        format.js { render partial: 'event/error2' }
      end
    end
  end
  
  def create_event3 # Beschreibung & Öffnungszeiten
    @event = Event.find(params[:id])    
    @event.update(description: params[:description])    
    
    json = JSON.parse(params[:opening_hours])
    index = 1
    json.each do |day|
      if day["isActive"]
           OpeningHour.create(location: Location.last, week_day: index, start_time: day["timeFrom"], end_time: day["timeTill"])
      end
     index += 1
     end
    
    @event.save
  end

  def edit
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    @event = Event.find(params[:id])
    image = params[:attachment]
    thumbnail = File.basename(image.original_filename, File.extname(image.original_filename)) + '-thumbnail' + File.extname(image.original_filename)

    source = Tinify.from_file(image.tempfile)
    resized_thumbnail = source.resize(
      method: "cover",
      width: 280,
      height: 160
    )

    resized = source.resize(
      method: "cover",
      width: 750,
      height: 440
    )

    resized.to_file('/tmp/' + image.original_filename)
    resized_thumbnail.to_file('/tmp/' + thumbnail)

    @event.images.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)
    @event.images_thumbnail.attach(io: File.open('/tmp/' + thumbnail), filename: thumbnail)

    @event.save!
    
  end

  def delete
  end
  
  private
  
  def event_params
    params.require(:event).permit(:location_id, :performer_id, :name, :category, :description, :start_time, :end_time, :pathname, :facebook_event, :image_url, :start_date, :end_date, :soundcloud, :status)
  end
  
end
