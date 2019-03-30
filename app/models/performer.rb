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
  
  def url 
    return 'https://radr2-leondahmer.codeanyapp.com' + '/performer/' + self.id.to_s
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
  
end
