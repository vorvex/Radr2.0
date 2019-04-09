class PageView < ApplicationRecord

  has_one :session 
  belongs_to :user 

  def self.trend
    hits = group_by_week(:created_at, last: 2).count
    this = hits.values.last
    last = hits.values.first
    
    if this > last
      return "positive"
    elsif this == last
      return "neutral"
    elsif this < last
      return "negative"
    end
  end
  
  def device
      if self.user_agent.include?('iPhone') 
        return "iOS"
      elsif self.user_agent.include?('Android')
        return "Android"
      elsif self.user_agent.include?('Firefox')
        return "Firefox"
      elsif self.user_agent.include?('Chrome')
        return "Chrome"
      elsif self.user_agent.include?('Safari')
        return "Safari"
      elsif self.user_agent.include?('Windows NT')
        return "Internet Explorer"
      else
        return "Sonstige"
      end
  end
end
