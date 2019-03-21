class ChangeYtvideoOnEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column(:events, "yt-video", :yt_video)
  end
end
