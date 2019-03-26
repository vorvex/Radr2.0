class PerformerController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create_performer1 # Name, Category, Start & Endtime
    Time.zone = "Berlin"
    name = params[:performername]
    
    @performer = Performer.new(user_id: current_user.id, name: params[:performername], category: params[:performer][:category], description: params[:description])

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
    
     if !@performer.profile_image.attached? 
       
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
  end

  def edit
    require "tinify"
    Tinify.key = "CQXQ1v8qCGY7FLND9P1mSXtqPyVdBF3r"
    
    @performer = Performer.find(params[:id])
    
    image = params[:attachment]
    thumbnail = File.basename(image.original_filename, File.extname(image.original_filename)) + '-thumbnail' + File.extname(image.original_filename)

    source = Tinify.from_file(image.tempfile)
    resized_thumbnail = source.resize(
      method: "thumb",
      width: 80,
      height: 80
    )

    resized = source.resize(
      method: "thumb",
      width: 400,
      height: 400
    )

    resized.to_file('/tmp/' + image.original_filename)
    resized_thumbnail.to_file('/tmp/' + thumbnail)


    @performer.profile_image.attach(io: File.open('/tmp/' + image.original_filename), filename: image.original_filename)
    @performer.profile_image_thumbnail.attach(io: File.open('/tmp/' + thumbnail), filename: thumbnail)

    @performer.save!
  end

  def delete
  end
end
