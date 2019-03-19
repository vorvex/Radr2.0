class Performer < ApplicationRecord
  belongs_to :user
  has_many :social_links, dependent: :destroy
  has_many :events
  
  has_one_attached :profile_image
  has_one_attached :profile_image_thumbnail
  
  def upcoming_events
    self.events.where('start_time > ?', Time.now).order('start_time ASC')
  end
  
  def finished_events
    self.events.where('start_time < ?', Time.now)
  end
  
end
