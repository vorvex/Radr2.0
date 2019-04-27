class OrganizerController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'dashboard'
  
  def create_organizer1 # Name, Category, Start & Endtime
    name = params[:organizername]
    
    path = name.downcase.gsub(" ", "-").gsub('ö', 'oe').gsub('ä', 'ae').gsub('ü', 'ue').gsub('ß', 'ss')
    x = 0
    while !Organizer.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    
    @organizer = Organizer.new(user_id: current_user.id, name: params[:organizername], category: params[:organizer][:category], description: params[:description], path: path)

    @organizer.save
    respond_to do |format|
      format.js { render partial: 'organizer/success1' }
    end
    
  end
  
  def add_image # Bilder
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    if params[:id] == 0
      @organizer = Organizer.last
    else
      @organizer = Organizer.find(params[:id])
    end
    
        image = params[:file]
       
        source = Tinify.from_file(image.tempfile)
        resized = source.resize(
          method: "cover",
          width: 750,
          height: 440
        )

        resized.to_file('/tmp/' + image.original_filename)

        @organizer.images.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)

  end
  
  def add_profile_image # Bilder
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    if params[:id] == 0
      @organizer = Organizer.last
    else
      @organizer = Organizer.find(params[:id])
    end
    
    image = params[:file]
       
      thumbnail = File.basename(image.original_filename, File.extname(image.original_filename)) + '-thumbnail' + File.extname(image.original_filename)

      source_thumbnail = Tinify.from_file(image.tempfile)
      resized_thumbnail = source_thumbnail.resize(
        method: "cover",
        width: 80,
        height: 80
      )
       resized_thumbnail.to_file('/tmp/' + thumbnail)
       @organizer.profile_image_thumbnail.attach(io: File.open('/tmp/' + thumbnail), filename: thumbnail)

        source = Tinify.from_file(image.tempfile)
        resized = source.resize(
          method: "cover",
          width: 750,
          height: 440
        )

        resized.to_file('/tmp/' + image.original_filename)

        @organizer.profile_image.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)

  end

  def edit_images
    @organizer = Organizer.find(params[:id])
  end
  
  def edit_profile_image
    @organizer = Organizer.find(params[:id])
  end
  
  def edit_informations
    @organizer = Organizer.find(params[:id])
  end
  
  def update_informations
    @organizer = Organizer.find(params[:id])
    @organizer.update(name: params[:organizer][:name], category: params[:organizer][:category], description: params[:organizer][:description])
    
    @organizer.save
    
    path = '/?profile=' + @organizer.id.to_s + '&type=organizer'
    
    redirect_to path
  end
  
  def events
    @organizer = Organizer.find(params[:id])
    @own_events = @organizer.own_events
  end
  
  def share
    @resource = Organizer.find(params[:id])
  end
  
  def social_links
    @organizer = Organizer.find(params[:id])
    @social_links = @organizer.social_links
  end
  
  def requests
    @organizer = Organizer.find(params[:id])
    @requests = @organizer.organizer_requests
    @new_requests = @requests.where('created_at = updated_at').where(accepted: false)
    @accepted_requests = @requests.where(accepted: true)
  end
  
  def edit_social_links
    @organizer = Organizer.find(params[:id])
    @facebook = @organizer.social_links.find_by_channel('Facebook')
    @instagram = @organizer.social_links.find_by_channel('Instagram')
    @youtube = @organizer.social_links.find_by_channel('YouTube')
    @soundcloud = @organizer.social_links.find_by_channel('SoundCloud')
    @webseite = @organizer.social_links.find_by_channel('Webseite')
    
    if @facebook.nil? && params[:facebook] != ""
      SocialLink.create(channel: 'Facebook', url: params[:facebook], organizer_id: @organizer.id)
    elsif !@facebook.nil? && params[:facebook] != ""
      @facebook.update(url: params[:facebook])
    elsif !@facebook.nil? && params[:facebook] == ""
      @facebook.delete
    end
    
    if @instagram.nil? && params[:instagram] != ""
      SocialLink.create(channel: 'Instagram', url: params[:instagram], organizer_id: @organizer.id)
    elsif !@instagram.nil? && params[:instagram] != ""
      @instagram.update(url: params[:instagram])
    elsif !@instagram.nil? && params[:instagram] == ""
      @instagram.delete
    end
    
    if @youtube.nil? && params[:youtube] != ""
      SocialLink.create(channel: 'YouTube', url: params[:youtube], organizer_id: @organizer.id)
    elsif !@youtube.nil? && params[:youtube] != ""
      @youtube.update(url: params[:youtube])
    elsif !@youtube.nil? && params[:youtube] == ""
      @youtube.delete
    end
    
    if @soundcloud.nil? && params[:soundcloud] != ""
      SocialLink.create(channel: 'SoundCloud', url: params[:soundcloud], organizer_id: @organizer.id)
    elsif !@soundcloud.nil? && params[:soundcloud] != ""
      @soundcloud.update(url: params[:soundcloud])
    elsif !@soundcloud.nil? && params[:soundcloud] == ""
      @soundcloud.delete
    end
    
    if @webseite.nil? && params[:webseite] != ""
      SocialLink.create(channel: 'Webseite', url: params[:webseite], organizer_id: @organizer.id)
    elsif !@webseite.nil? && params[:webseite] != ""
      @webseite.update(url: params[:webseite])
    elsif !@webseite.nil? && params[:webseite] == ""
      @webseite.delete
    end
    
    path = '/?profile=' + @organizer.id.to_s + '&type=organizer'
    
    redirect_to path
    
  end
  
  def create_from_event
    name = params[:organizername]
    event = params[:event]
    
    path = name.downcase.gsub(" ", "-").gsub('ö', 'oe').gsub('ä', 'ae').gsub('ü', 'ue').gsub('ß', 'ss')
    x = 0
    while !Organizer.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    
    @organizer = Organizer.new(name: params[:organizername], category: params[:organizercategory], path: path)

    if @organizer.save     
      if @organizer_request = OrganizerRequest.create(organizer_id: @organizer.id, event_id: event)
        respond_to do |format|
          format.js { render partial: 'organizer/success_from_event' }
        end
      end
    end
  end
  
  def organizer_request
    @event = params[:event_id].to_i
    organizer = params[:organizer_id].to_i
    
    @organizer = Organizer.find(organizer)
    
    @organizer_request = OrganizerRequest.new(organizer_id: @organizer.id, event_id: @event)
    if @organizer_request.save
      respond_to do |format|
         format.js { render partial: 'organizer/request_success' }
       end
    end
  end
  
  def search_from_event
    @event = params[:event]
    search = params[:organizer_search]
    @organizers = Organizer.where('LOWER(name) LIKE ?', "%#{search.downcase}%").limit(10)

    respond_to do |format|
      format.js { render partial: 'organizer/search' }
    end
  end
  
  def update_organizer_request
    if params[:accepted] == "true"
      OrganizerRequest.find(params[:id]).update(accepted: true)    
    else 
      OrganizerRequest.find(params[:id]).update(accepted: false) 
    end
  end
  
  def delete_organizer_request
    @event = params[:event_id].to_i
    performer_request_id = params[:performer_request_id].to_i
    
    OrganizerRequest.find(organizer_request_id).delete
    
  end
  
  
   def delete
    @profile = Organizer.find(params[:id])
    @profile.delete
    
    respond_to do |format|
      format.js { render partial: 'organizer/destroyed' }
    end
  end
end
