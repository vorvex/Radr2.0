class Performer < ApplicationRecord
  has_one :user
  has_many :social_links, dependent: :destroy
  has_many :events
  
  has_one_attached :profile_image
  has_one_attached :profile_image_thumbnail
  
  def events
    Event.where('performer_id IS ?', self.id)
  end
  
  def upcoming_events
    self.events.where('start_time > ?', Time.now).order('start_time ASC')
  end
  
  def finished_events
    self.events.where('start_time < ?', Time.now)
  end
  
  def self.categories
    arr = ['', 'DJ', 'Band', 'Sänger', 'Unterhalter', 'Künstler', 'Tanzgruppe']
    return arr
  end
  
  def category_schema
    return self.category
  end
  
  def url 
    return '/performer/' + self.path
  end
  
  def user
    if self.user_id.nil?
      return nil
    else
      User.find(self.user_id)
    end
  end
  
  def images
    arr = []
    arr << self.profile_image
  end
  
  def path_str
    path = self.name.downcase.gsub(" ", "-")
    x = 0
    while !Performer.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    return path
  end
  
end
