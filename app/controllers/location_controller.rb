class LocationController < ApplicationController
   skip_before_action :verify_authenticity_token
  
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
    
    @location = Location.create(user_id: current_user.id, name: name, category: category, formatted_address: formatted_address, 
                                route: route, street_number: street_number, postal_code: postal_code, locality: locality, lat: lat, lng: lng)
    
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
     end
    
    @location.save
  end

  def edit
  end

  def delete
  end
  
  private
  
  
end
