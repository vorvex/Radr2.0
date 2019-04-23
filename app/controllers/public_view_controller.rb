class PublicViewController < ApplicationController
  before_action :set_session
  
  
  def location     
    @request = request.user_agent
    @resource = Location.find_by_path(params[:path])   
    @user = @resource.user
    @day = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
    
    @title = @resource.name 
    if @title.length < 50
      @title += " | "
      @title += @resource.category
    end
    @image = url_for(@resource.images.first)
    @description = @resource.category + " in " + @resource.locality + ". " + @resource.description
    @type = "Location"
    
  end

  def event
    @resource = Event.find_by_path(params[:path])
    @user = @resource.user
    @title = @resource.name
    if @title.length < 50
      @title += " | "
      @title += @resource.location.name
    end
    @image = url_for(@resource.images.first)
    @description = @resource.category_str + " am " + @resource.time_str + ". " + @resource.description_str
    @type = "Event"
    
    
  end

  def performer
    @resource = Performer.find_by_path(params[:path])
    @user = @resource.user
    @title = @resource.name
    @image = url_for(@resource.profile_image)
    @description = @resource.description
    @type = "Performer"
    
  end
  
  def tickets
    @resource = Event.find_by_path(params[:path]).tickets
    @user = Event.find_by_path(params[:path]).user
    @title =Event.find_by_path(params[:path]).name
    @image = url_for(Event.find_by_path(params[:path]).images.first)
    @description = "Ticketinformationen für " + Event.find_by_path(params[:path]).name
  end
  
  private
  
  def set_session
    if cookies[:session_token].nil?
      session = Session.create()
      cookies[:session_token] = { value: session.token, expires: Time.now + 3600}
    end
  end
  
  def user_agent 
    @user_agent = request.user_agent
    
    case 
      when @user_agent.include?('iPhone')
        layout 'application_mobile'
      when @user_agent.include?('Android')
        layout 'application_mobile'
    else
        layout 'application'
    end
  end 
  
  def soundcloud
        @soundcloud = @resource.social_links.find_by_channel("SoundCloud")
    
    if !@soundcloud.nil?
      require 'soundcloud'
      # create a client object with your app credentials
      client = Soundcloud.new(:client_id => 'FweeGBOOEOYJWLJN3oEyToGLKhmSz0I7')

      # get a tracks oembed data
      track_url = @soundcloud.url
      embed_info = client.get('/oembed', :url => track_url)
      embed_info.gsub!('src', 'title="soundcloud" data-src')
      
      # print the html for the player widget
      @soundcloud_iframe = embed_info['html']
    end
  end
  
end
