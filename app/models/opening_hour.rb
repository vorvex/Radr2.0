class OpeningHour < ApplicationRecord
  belongs_to :location
  
  def str
    if start_time != nil
      return "Geöffnet von #{start_time} bis #{end_time}"
    else
      return "<span style='color: #FF2D55'>Geschlossen</span>"
    end
  end
  
  def day_str 
    case self.week_day
      when 0
        return "Sonntag"
      when 1
        return "Montag"
      when 2
        return "Dienstag"
      when 3
        return "Mittwoch"
      when 4
        return "Donnerstag"
      when 5
        return "Freitag"
      when 6
        return "Samstag"
    end 
  end
  
end
