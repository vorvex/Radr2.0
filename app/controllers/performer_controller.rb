class PerformerController < ApplicationController
  def create
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
