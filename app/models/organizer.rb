class Organizer < ApplicationRecord
  has_many :organizer_requests
  has_many :events, -> { where organizer_requests: { accepted: true } } ,
           :through => :organizer_requests, 
           :class_name => "Event", 
           :source => :event
  has_many :social_links
  belongs_to :user
  
  has_one_attached :profile_image
  has_one_attached :profile_image_thumbnail
  has_many_attached :images
  
  def self.categories
    arr = ['', 'Kategorie 1', 'Kategorie 2', 'Kategorie 3', 'Kategorie 4', 'Kategorie 5', 'Kategorie 6', 'Kategorie 7']
    return arr
  end
  
  def own_events
    user = User.find(self.user_id)    
    self.events.where('user_id = ?', user.id)
  end
  
  def upcoming_events
    self.events.where('start_time > ?', Time.now).order('start_time ASC')
  end
  
  def url 
    return '/organizer/' + self.path
  end
  
end
