class EventController < ApplicationController
  def create
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
