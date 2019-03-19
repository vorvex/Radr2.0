class SocialLink < ApplicationRecord
  belongs_to :performer
  belongs_to :location
  
  def buttons
    case self.channel
      when "Instagram"
        return '<a href="https://www.instagram.com/#{self.url}" class="social-button"><img src="/images/instagram.svg" alt="Instagram"></a>'
      when "Facebook"
        return '<a href="https://www.facebook.com/#{self.url}" class="social-button"><img src="/images/facebook.svg" alt="Facebook"></a>'
      when "Soundcloud"
        return '<a href="https://www.facebook.com/#{self.url}" class="social-button"><img src="/images/soundcloud.svg" alt="Soundcloud"></a>'
    end
  end
end
