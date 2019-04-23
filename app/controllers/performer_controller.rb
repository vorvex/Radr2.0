class PerformerController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout 'dashboard'
  
  def create_performer1 # Name, Category, Start & Endtime
    name = params[:performername]
    
    path = name.downcase.gsub(" ", "-").gsub('ö', 'oe').gsub('ä', 'ae').gsub('ü', 'ue').gsub('ß', 'ss')
    x = 0
    while !Performer.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    
    @performer = Performer.new(user_id: current_user.id, name: params[:performername], category: params[:performer][:category], description: params[:description], path: path)

    @performer.save
    respond_to do |format|
      format.js { render partial: 'performer/success1' }
    end
    
  end
  
  def add_image # Bilder
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    if params[:id] == 0
      @performer = Performer.last
    else
      @performer = Performer.find(params[:id])
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
       @performer.profile_image_thumbnail.attach(io: File.open('/tmp/' + thumbnail), filename: thumbnail)

        source = Tinify.from_file(image.tempfile)
        resized = source.resize(
          method: "cover",
          width: 400,
          height: 400
        )

        resized.to_file('/tmp/' + image.original_filename)

        @performer.profile_image.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)

  end

  def edit_images
    @performer = Performer.find(params[:id])
  end
  
  def edit_informations
    @performer = Performer.find(params[:id])
  end
  
  def update_informations
    @performer = Performer.find(params[:id])
    @performer.update(name: params[:performer][:name], category: params[:performer][:category], description: params[:performer][:description])
    
    @performer.save
    
    path = '/?profile=' + @performer.id.to_s + '&type=performer'
    
    redirect_to path
  end
  
  def events
    @performer = Performer.find(params[:id])
    @own_events = @performer.own_events
  end
  
  def share
    @resource = Performer.find(params[:id])
  end
  
  def social_links
    @performer = Performer.find(params[:id])
    @social_links = @performer.social_links
  end
  
  def requests
    @performer = Performer.find(params[:id])
    @requests = @performer.performer_requests
    @new_requests = @requests.where('created_at = updated_at').where(accepted: false)
    @accepted_requests = @requests.where(accepted: true)
  end
  
  def edit_social_links
    @performer = Performer.find(params[:id])
    @facebook = @performer.social_links.find_by_channel('Facebook')
    @instagram = @performer.social_links.find_by_channel('Instagram')
    @youtube = @performer.social_links.find_by_channel('YouTube')
    @soundcloud = @performer.social_links.find_by_channel('SoundCloud')
    @webseite = @performer.social_links.find_by_channel('Webseite')
    
    if @facebook.nil? && params[:facebook] != ""
      SocialLink.create(channel: 'Facebook', url: params[:facebook], performer_id: @performer.id)
    elsif !@facebook.nil? && params[:facebook] != ""
      @facebook.update(url: params[:facebook])
    elsif !@facebook.nil? && params[:facebook] == ""
      @facebook.delete
    end
    
    if @instagram.nil? && params[:instagram] != ""
      SocialLink.create(channel: 'Instagram', url: params[:instagram], performer_id: @performer.id)
    elsif !@instagram.nil? && params[:instagram] != ""
      @instagram.update(url: params[:instagram])
    elsif !@instagram.nil? && params[:instagram] == ""
      @instagram.delete
    end
    
    if @youtube.nil? && params[:youtube] != ""
      SocialLink.create(channel: 'YouTube', url: params[:youtube], performer_id: @performer.id)
    elsif !@youtube.nil? && params[:youtube] != ""
      @youtube.update(url: params[:youtube])
    elsif !@youtube.nil? && params[:youtube] == ""
      @youtube.delete
    end
    
    if @soundcloud.nil? && params[:soundcloud] != ""
      SocialLink.create(channel: 'SoundCloud', url: params[:soundcloud], performer_id: @performer.id)
    elsif !@soundcloud.nil? && params[:soundcloud] != ""
      @soundcloud.update(url: params[:soundcloud])
    elsif !@soundcloud.nil? && params[:soundcloud] == ""
      @soundcloud.delete
    end
    
    if @webseite.nil? && params[:webseite] != ""
      SocialLink.create(channel: 'Webseite', url: params[:webseite], performer_id: @performer.id)
    elsif !@webseite.nil? && params[:webseite] != ""
      @webseite.update(url: params[:webseite])
    elsif !@webseite.nil? && params[:webseite] == ""
      @webseite.delete
    end
    
    path = '/?profile=' + @performer.id.to_s + '&type=performer'
    
    redirect_to path
    
  end
  
  def create_from_event
    name = params[:performername]
    event = params[:event]
    
    path = name.downcase.gsub(" ", "-").gsub('ö', 'oe').gsub('ä', 'ae').gsub('ü', 'ue').gsub('ß', 'ss')
    x = 0
    while !Performer.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    
    @performer = Performer.new(name: params[:performername], category: params[:performercategory], path: path)

    if @performer.save     
      if @performer_request = PerformerRequest.create(performer_id: @performer.id, event_id: event)
        respond_to do |format|
          format.js { render partial: 'performer/success_from_event' }
        end
      end
    end
  end
  
  def performer_request
    @event = params[:event_id].to_i
    performer = params[:performer_id].to_i
    
    @performer = Performer.find(performer)
    
    @performer_request = PerformerRequest.new(performer_id: performer, event_id: @event)
    if @performer_request.save
      respond_to do |format|
         format.js { render partial: 'performer/request_success' }
       end
    end
  end
  
  def search_from_event
    @event = params[:event]
    search = params[:performer_search]
    @performers = Performer.where('LOWER(name) LIKE ?', "%#{search.downcase}%").limit(10)

    respond_to do |format|
      format.js { render partial: 'performer/search' }
    end
  end
  
  def update_performer_request
    if params[:accepted] == "true"
      PerformerRequest.find(params[:id]).update(accepted: true)    
    else 
      PerformerRequest.find(params[:id]).update(accepted: false) 
    end
  end
  
  def delete_performer_request
    @event = params[:event_id].to_i
    performer_request_id = params[:performer_request_id].to_i
    
    PerformerRequest.find(performer_request_id).delete
    
  end
  
  
   def delete
    @profile = Performer.find(params[:id])
    @profile.delete
    
    respond_to do |format|
      format.js { render partial: 'performer/destroyed' }
    end
  end
end
