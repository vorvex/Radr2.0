class LocationController < ApplicationController
   skip_before_action :verify_authenticity_token
   layout "dashboard"
  
  def create_location1 # Name, Category, Adresse
    name = params[:locationname]
    category = params[:category]
    formatted_address = params[:formatted_address]
    route = params[:route]
    street_number = params[:street_number]
    postal_code = params[:postal_code]
    locality = params[:locality]
    # place_id = params[:place_id]
    lat = params[:lat]
    lng = params[:lng]
    
    path = (locality + " " + name).downcase.gsub(" ", "-")
    x = 0
    while !Location.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    
    @location = Location.create(user_id: current_user.id, name: name, category: category, formatted_address: formatted_address, 
                                route: route, street_number: street_number, postal_code: postal_code, locality: locality, lat: lat, lng: lng, path: path)
    
    if @location.save
      respond_to do |format|
        format.js { render partial: 'location/success1' }
      end
    else
      respond_to do |format|
        format.js { render partial: 'location/error1', resource: "Location"  }
      end
    end
    
  end
  
  def add_images # Profilbild & Bilder
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    if params[:id] == 0
      @location = Location.last
    else
      @location = Location.find(params[:id])
    end
    
    if current_user.max_files == @location.images.length
      respond_to do |format|
        format.js {render :status => 500}
      end
    end
    
    image = params[:file]
    
     if !@location.thumbnail.attached? 
       
      thumbnail = File.basename(image.original_filename, File.extname(image.original_filename)) + '-thumbnail' + File.extname(image.original_filename)

      source_thumbnail = Tinify.from_file(image.tempfile)
      resized_thumbnail = source_thumbnail.resize(
        method: "cover",
        width: 80,
        height: 80
      )
       resized_thumbnail.to_file('/tmp/' + thumbnail)
       @location.thumbnail.attach(io: File.open('/tmp/' + thumbnail), filename: thumbnail)
       
     end
      
        source = Tinify.from_file(image.tempfile)
        resized = source.resize(
          method: "cover",
          width: 750,
          height: 440
        )

        resized.to_file('/tmp/' + image.original_filename)

        @location.images.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)
    
  end
  
  def create_location3 # Beschreibung & Öffnungszeiten
    @location = Location.find(params[:id])    
    @location.update(description: params[:description])    
    
    json = JSON.parse(params[:opening_hours])
    index = 1
    json.each do |day|
      if day["isActive"]
           OpeningHour.create(location: @location, week_day: index, start_time: day["timeFrom"], end_time: day["timeTill"])
      end
     index += 1
     if index === 7
       index = 0
     end
     end
    
    @location.save
  end

  def edit_images
    @location = Location.find(params[:id])
  end

  def edit_informations
    @location = Location.find(params[:id])
  end
  
  def update_informations
    formatted_address = params[:formatted_address]
    route = params[:route]
    street_number = params[:street_number]
    postal_code = params[:postal_code]
    locality = params[:locality]
    # place_id = params[:place_id]
    lat = params[:lat]
    lng = params[:lng]
    
    @location = Location.find(params[:id])
    @location.update(name: params[:location][:name], description: params[:location][:description], category: params[:location][:category], 
                     formatted_address: formatted_address, route: route, street_number: street_number, postal_code: postal_code, locality: locality, lat: lat, lng: lng)
    @location.save
    
    path = '/?profile=' + @location.id.to_s + '&type=location'
    
    redirect_to path
  end
  
  def opening_hours 
    @location = Location.find(params[:id])
    @opening_hours = @location.opening_hours
    @special_hours = OpeningHour.new()
    
  end
  
  def update_opening_hours
    @location = Location.find(params[:id])
    if params[:opening_hours] != ''
      
      json = JSON.parse(params[:opening_hours])
      index = 1
      json.each do |day|
        wday = @location.opening_hours.find_by_week_day(index)
        if wday.nil? && day["isActive"]
           OpeningHour.create(location: @location, week_day: index, start_time: day["timeFrom"], end_time: day["timeTill"])
        elsif !wday.nil? && day["isActive"]
          wday.update(start_time: day["timeFrom"], end_time: day["timeTill"])
        elsif !wday.nil? && !day["isActive"]
          wday.delete!
        end
         index += 1 
         if index === 7
           index = 0
         end
       end
    end
      
    path = '/?profile=' + @location.id.to_s + '&type=location'
    
    redirect_to path
    
  end
  
  def share
    @location = Location.find(params[:id])
  end
  
  def events
    @location = Location.find(params[:id])
    @events = @location.events
  end
  
  def social_links
    @location = Location.find(params[:id])
    @social_links = @location.social_links
  end
  
  def edit_social_links
    @location = Location.find(params[:id])
    @facebook = @location.social_links.find_by_channel('Facebook')
    @instagram = @location.social_links.find_by_channel('Instagram')
    @youtube = @location.social_links.find_by_channel('YouTube')
    @soundcloud = @location.social_links.find_by_channel('SoundCloud')
    @webseite = @location.social_links.find_by_channel('Webseite')
    
    if @facebook.nil? && params[:facebook] != ""
      SocialLink.create(channel: 'Facebook', url: params[:facebook], location_id: @location.id)
    elsif !@facebook.nil? && params[:facebook] != ""
      @facebook.update(url: params[:facebook])
    elsif !@facebook.nil? && params[:facebook] == ""
      @facebook.delete
    end
    
    if @instagram.nil? && params[:instagram] != ""
      SocialLink.create(channel: 'Instagram', url: params[:instagram], location_id: @location.id)
    elsif !@instagram.nil? && params[:instagram] != ""
      @instagram.update(url: params[:instagram])
    elsif !@instagram.nil? && params[:instagram] == ""
      @instagram.delete
    end
    
    if @youtube.nil? && params[:youtube] != ""
      SocialLink.create(channel: 'YouTube', url: params[:youtube], location_id: @location.id)
    elsif !@youtube.nil? && params[:youtube] != ""
      @youtube.update(url: params[:youtube])
    elsif !@youtube.nil? && params[:youtube] == ""
      @youtube.delete
    end
    
    if @soundcloud.nil? && params[:soundcloud] != ""
      SocialLink.create(channel: 'SoundCloud', url: params[:soundcloud], location_id: @location.id)
    elsif !@soundcloud.nil? && params[:soundcloud] != ""
      @soundcloud.update(url: params[:soundcloud])
    elsif !@soundcloud.nil? && params[:soundcloud] == ""
      @soundcloud.delete
    end
    
    if @webseite.nil? && params[:webseite] != ""
      SocialLink.create(channel: 'Webseite', url: params[:webseite], location_id: @location.id)
    elsif !@webseite.nil? && params[:webseite] != ""
      @webseite.update(url: params[:webseite])
    elsif !@webseite.nil? && params[:webseite] == ""
      @webseite.delete
    end
    
    path = '/?profile=' + @location.id.to_s + '&type=location'
    
    redirect_to path
    
  end
  
  def delete
    @profile = Location.find(params[:id])
    @profile.delete
    
    respond_to do |format|
      format.js { render partial: 'location/destroyed' }
    end
  end
  
  private
  
  
end
