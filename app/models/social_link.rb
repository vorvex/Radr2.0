class SocialLink < ApplicationRecord
  has_one :performer
  has_one :location
  has_one :event
  
  def self.channels
    arr = ['Instagram', 'Facebook', 'SoundCloud', 'YouTube', 'Webseite']
    return arr
  end
  
  def buttons
    case self.channel
      when "Instagram"
        return '<a href="https://www.instagram.com/' + self.url + '" class="social-button"><img src="/images/instagram.svg" alt="Instagram"></a>'
      when "Facebook"
        return '<a href="https://www.facebook.com/' + self.url + '" class="social-button"><img src="/images/facebook.svg" alt="Facebook"></a>'
      when "SoundCloud"
        return '<a href="' + self.url + '" class="social-button"><img src="/images/soundcloud.svg" alt="Soundcloud"></a>'
      
      when "Webseite"
        return '<a href="' + self.url + '" class="social-button"><img src="/images/webseite.svg" alt="Webseite"></a>'
      
      when "YouTube"
        return ''
    end
  end
 
  
  def links
    case self.channel
      when "Instagram"
        return '<a href="https://www.instagram.com/' + self.url + '" target="_blank" rel="noreferrer">
                  <div>
                    <h2>' + self.url + '</h2>
                    <span class="subheader">Instagram</span>
                  </div>
                  <span class="oh-button">    
                    <svg width="8px" height="12px" viewBox="0 0 8 12" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                            <g  transform="translate(-350.000000, -608.000000)" fill="#000000" fill-rule="nonzero">
                                <g  transform="translate(10.000000, 593.000000)">
                                    <g transform="translate(340.000000, 15.000000)">
                                        <polygon points="0 0.7275 0.77625 0 7.2 6 0.77625 12 0 11.27625 5.64375 6"></polygon>
                                    </g>
                                </g>
                            </g>
                        </g>
                    </svg>
                  </span>
                </a>'
      when "Webseite"
        return '<a href="https://www.instagram.com/' + self.url + '" target="_blank" rel="noreferrer">
                  <div>
                    <h2>' + self.url + '</h2>
                    <span class="subheader">Webseite</span>
                  </div>
                  <span class="oh-button">    
                    <svg width="8px" height="12px" viewBox="0 0 8 12" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                            <g  transform="translate(-350.000000, -608.000000)" fill="#000000" fill-rule="nonzero">
                                <g  transform="translate(10.000000, 593.000000)">
                                    <g transform="translate(340.000000, 15.000000)">
                                        <polygon points="0 0.7275 0.77625 0 7.2 6 0.77625 12 0 11.27625 5.64375 6"></polygon>
                                    </g>
                                </g>
                            </g>
                        </g>
                    </svg>
                  </span>
                </a>'
    end
  end
  
end
