class PublicViewController < ApplicationController
  before_action :set_session
  
  def location     
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
    
    @soundcloud = @resource.social_links.find_by_channel("SoundCloud")
    
    if !@soundcloud.nil?
      require 'soundcloud'
      # create a client object with your app credentials
      client = Soundcloud.new(:client_id => 'L4uORyiM1NIPHMzZNvMUHBdeFbhHkW9b')

      # get a tracks oembed data
      track_url = @soundcloud.url
      embed_info = client.get('/oembed', :url => track_url)
      embed_info.gsub!('src', 'data-src')
      
      # print the html for the player widget
      @soundcloud_iframe = embed_info['html']
    end
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
    @description = @resource.category + " am " + @resource.date_str + ". " + @resource.description
    @type = "Event"
    
    @soundcloud = @resource.social_links.find_by_channel("SoundCloud")
    
    if !@soundcloud.nil?
      require 'soundcloud'
      # create a client object with your app credentials
      client = Soundcloud.new(:client_id => 'L4uORyiM1NIPHMzZNvMUHBdeFbhHkW9b')

      # get a tracks oembed data
      track_url = @soundcloud.url
      embed_info = client.get('/oembed', :url => track_url)
      embed_info.gsub!('src', 'data-src')
      
      # print the html for the player widget
      @soundcloud_iframe = embed_info['html']
    end
  end

  def performer
    @resource = Performer.find_by_path(params[:path])
    @user = @resource.user
    @title = @resource.name
    @image = url_for(@resource.profile_image)
    @description = @resource.description
    @type = "Performer"
    
    @soundcloud = @resource.social_links.find_by_channel("SoundCloud")
    
    if !@soundcloud.nil?
      require 'soundcloud'
      # create a client object with your app credentials
      client = Soundcloud.new(:client_id => 'L4uORyiM1NIPHMzZNvMUHBdeFbhHkW9b')

      # get a tracks oembed data
      track_url = @soundcloud.url
      embed_info = client.get('/oembed', :url => track_url)
      embed_info.gsub!('src', 'data-src')
      
      # print the html for the player widget
      @soundcloud_iframe = embed_info['html']
    end
  end
  
  def tickets
    @resource = Event.find_by_path(params[:path]).tickets
    @user = @resource.user
    @title = @resource.event.name
    @image = url_for(@resource.event.images.first)
    @description = "Ticketinformationen für " + @resource.event.name
  end
  
  private
  
  def set_session
    if cookies[:session_token].nil?
      session = Session.create()
      cookies[:session_token] = { value: session.token, expires: Time.now + 3600}
    end
  end
  
end
