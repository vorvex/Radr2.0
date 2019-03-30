class SocialLink < ApplicationRecord
  has_one :performer
  has_one :location
  
  def self.channels
    arr = ['Instagram', 'Facebook', 'SoundCloud', 'YouTube']
    return arr
  end
  
  def buttons
    case self.channel
      when "Instagram"
        return '<a href="https://www.instagram.com/' + self.url + '" class="social-button"><img src="/images/instagram.svg" alt="Instagram"></a>'
      when "Facebook"
        return '<a href="https://www.facebook.com/' + self.url + '" class="social-button"><img src="/images/facebook.svg" alt="Facebook"></a>'
      when "Soundcloud"
        return '<a href="https://www.facebook.com/' + self.url + '" class="social-button"><img src="/images/soundcloud.svg" alt="Soundcloud"></a>'
    end
  end
end
