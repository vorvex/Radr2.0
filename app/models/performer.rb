class Performer < ApplicationRecord
  belongs_to :user
  has_many :social_links, dependent: :destroy
  has_many :events
  
  def upcoming_events
    self.events.where('start_time > ?', Time.now).order('start_time ASC')
  end
  
  def finished_events
    self.events.where('start_time < ?', Time.now)
  end
  
end
