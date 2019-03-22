class LocationController < ApplicationController
   skip_before_action :verify_authenticity_token
  
  def create_location1 # Name, Category, Adresse
    name = params[:name]
    category = params[:category]
    formatted_address = params[:formatted_address]
    route = params[:route]
    street_number = params[:street_number]
    postal_code = params[:postal_code]
    locality = params[:locality]
    # place_id = params[:place_id]
    lat = params[:lat]
    lng = params[:lng]
    
    @location = Location.create(user_id: User.first.id, name: name, category: category, formatted_address: formatted_address, 
                                route: route, street_number: street_number, postal_code: postal_code, locality: locality, lat: lat, lng: lng)
    
    if @location.save
      respond_to do |format|
        format.js { render partial: 'location/success1' }
      end
    else
      respond_to do |format|
        format.js { render partial: 'location/error1' }
      end
    end
    
  end
  
  def create_location2 # Profilbild & Bilder
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    
    @location = Location.find(params[:id])
    
    images = params[:location][:attachment]
    
    if images != nil
    
      thumbnail = File.basename(images.first.original_filename, File.extname(images.first.original_filename)) + '-thumbnail' + File.extname(images.first.original_filename)

      source = Tinify.from_file(images.first.tempfile)
      resized_thumbnail = source.resize(
        method: "thumb",
        width: 80,
        height: 80
      )
      images.each do |image| 
        resized = source.resize(
          method: "cover",
          width: 750,
          height: 440
        )

        resized.to_file('/tmp/' + image.original_filename)
        resized_thumbnail.to_file('/tmp/' + thumbnail)

        @location.images.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)
      end    
      @location.thumbnail.attach(io: File.open('/tmp/' + thumbnail), filename: thumbnail)
    
    end  
    if @location.thumbnail.attached?
      respond_to do |format|
        format.js { render partial: 'location/success2' }
      end
    else
      respond_to do |format|
        format.js { render partial: 'location/error2' }
      end
    end
  end
  
  def create_location3 # Beschreibung & Öffnungszeiten
    @location = Location.find(params[:id])    
    @location.update(description: params[:description])    
    
    json = JSON.parse(params[:opening_hours])
    index = 0
    json.each do |day|
      if day["isActive"]
           OpeningHour.create(location: Location.last, week_day: index, start_time: day["timeFrom"], end_time: day["timeTill"])
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
