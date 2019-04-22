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
    
    @event = Event.new(location: location, name: name, path: path, user_id: current_user.id)
    
    @event.start_time = Time.zone.strptime(startTime, "%d.%m.%Y %H:%M")
    if endTime != " "
      @event.end_time = Time.zone.strptime(endTime, "%d.%m.%Y %H:%M")
    end
    @event.save
    
    if params[:event][:profile] != nil
      if params[:event][:type] == 'performer'
        @performer = Performer.find(params[:event][:profile])
        PerformerRequest.create(performer_id: @performer.id, event_id: @event.id, accepted: true)
      end
    end
    
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
    
    if current_user.max_files == @event.images.length
      respond_to do |format|
        format.js {render :status => 500}
      end
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
    Time.zone = "Berlin"
    @event = Event.find(params[:id])
    @social_links = @event.social_links
    @start_date = @event.start_time.day.to_s.rjust(2, '0') + "." + @event.start_time.month.to_s.rjust(2, '0') + "." + @event.start_time.year.to_s
    @end_date = @event.end_time.day.to_s.rjust(2, '0') + "." + @event.end_time.month.to_s.rjust(2, '0') + "." + @event.end_time.year.to_s
  end
  
  def update
    Time.zone = "Berlin"
    @event = Event.find(params[:id])
    name = params[:event][:name]
    location = Location.find(params[:event][:location_id])
    startTime = params[:event][:start_date] + " " + params[:event][:start_time]
    endTime = params[:event][:end_date] + " " + params[:event][:end_time]
    
    
    @event.start_time = Time.zone.strptime(startTime, "%d.%m.%Y %H:%M")
    if endTime != " "
      @event.end_time = Time.zone.strptime(endTime, "%d.%m.%Y %H:%M")
    end
    
    @event.update(name: name , description: params[:description], category: params[:event][:category], location_id: location.id )
    
    @facebook = @event.social_links.find_by_channel('Facebook')
    @instagram = @event.social_links.find_by_channel('Instagram')
    @youtube = @event.social_links.find_by_channel('YouTube')
    @soundcloud = @event.social_links.find_by_channel('SoundCloud')
    @webseite = @event.social_links.find_by_channel('Webseite')
    
    if @facebook.nil? && params[:facebook] != ""
      SocialLink.create(channel: 'Facebook', url: params[:facebook], event_id: @event.id)
    elsif !@facebook.nil? && params[:facebook] != ""
      @facebook.update(url: params[:facebook])
    elsif !@facebook.nil? && params[:facebook] == ""
      @facebook.delete
    end
    
    if @instagram.nil? && params[:instagram] != ""
      SocialLink.create(channel: 'Instagram', url: params[:instagram], event_id: @event.id)
    elsif !@instagram.nil? && params[:instagram] != ""
      @instagram.update(url: params[:instagram])
    elsif !@instagram.nil? && params[:instagram] == ""
      @instagram.delete
    end
    
    if @youtube.nil? && params[:youtube] != ""
      SocialLink.create(channel: 'YouTube', url: params[:youtube], event_id: @event.id)
    elsif !@youtube.nil? && params[:youtube] != ""
      @youtube.update(url: params[:youtube])
    elsif !@youtube.nil? && params[:youtube] == ""
      @youtube.delete
    end
    
    if @soundcloud.nil? && params[:soundcloud] != ""
      SocialLink.create(channel: 'SoundCloud', url: params[:soundcloud], event_id: @event.id)
    elsif !@soundcloud.nil? && params[:soundcloud] != ""
      @soundcloud.update(url: params[:soundcloud])
    elsif !@soundcloud.nil? && params[:soundcloud] == ""
      @soundcloud.delete
    end
    
    if @webseite.nil? && params[:webseite] != ""
      SocialLink.create(channel: 'Webseite', url: params[:webseite], event_id: @event.id)
    elsif !@webseite.nil? && params[:webseite] != ""
      @webseite.update(url: params[:webseite])
    elsif !@webseite.nil? && params[:webseite] == ""
      @webseite.delete
    end
    
    @event.save

  end
  
  def select_plan
    @event = Event.find(params[:id])
    @event.update(plan: params[:plan])
  end
  
  def tickets
    @event = Event.find(params[:id])
    @tickets = @event.tickets
  end
  
  def delete
    @event = Event.find(params[:id])    
    @event.delete
    
    redirect_to "/"
  end
  
  private
  
  def event_params
    params.require(:event).permit(:location_id, :performer_id, :name, :category, :description, :start_time, :end_time, :pathname, :facebook_event, :image_url, :start_date, :end_date, :soundcloud, :status)
  end
  
end
