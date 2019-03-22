class Location < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :opening_hours, dependent: :destroy
  has_many :social_links
  
  has_one_attached :thumbnail
  
  has_many_attached :images
  
  def opening_table
    op = self.opening_hours
    arr = Array.new(7)
    arr.each_index.map {|x| arr[x] = op.find_by_week_day(x).str unless op.find_by_week_day(x).nil?}
    arr << arr[0]
    arr.shift
    return arr
  end
  
  def open? #1
    today = self.opening_hours.find_by_week_day(Date.today.wday)
    Time.zone = "Berlin"
    now = Time.zone.now.hour.to_f + (Time.zone.now.min.to_f / 60)
    if today.nil? #2
      return false
    else #2
      start_float = today.start_time[0..1].to_f + (today.start_time[3..3].to_f / 60)
      end_float = today.end_time[0..1].to_f + (today.end_time[3..3].to_f / 60)
      
      if now.between?(start_float, end_float) #3
        return true
      else #3
        return false
      end #3
    end #2
  end #1
  
  def open_string? #1
    Time.zone = "Berlin"
    now = Time.zone.now.hour.to_f + (Time.zone.now.min.to_f / 60)
    t = self.opening_hours.find_by_week_day(Date.today.wday)
    today = t
    if now < 5 #2
      now += 24
      today = self.opening_hours.find_by_week_day(Date.today.wday - 1)
    end #2
    
    if !today.nil? #2
      start_float = today.start_time[0..1].to_f + (today.start_time[3..3].to_f / 60)
      end_float = today.end_time[0..1].to_f + (today.end_time[3..3].to_f / 60)
      
      if end_float < start_float #3
        end_float += 24
      end #3            
      if now.between?(start_float, end_float) #3
        return "Geöffnet von #{today.start_time} bis #{today.end_time}"
      elsif now < start_float #3
        return "Geöffnet von #{today.start_time} bis #{today.end_time}"
      elsif now > end_float #3
        if now > 24 #4        
          if !t.nil? #5
            return "Geöffnet von #{t.start_time} bis #{t.end_time}"
          else #5
            return "Geschlossen"
          end #5
        else #4
          return "Geschlossen"
        end #4
      end #3
    else #2
      return "Heute Geschlossen" 
    end #2
  end #1
  
end
