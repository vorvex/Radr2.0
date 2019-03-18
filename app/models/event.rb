class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_one :performer
  belongs_to :location
  
  def self.upcoming
    where('start_time > ?', Time.now).order('start_time ASC')
  end
  
  def self.finished
    where('start_time < ?', Time.now)
  end
  
  def self.find_by_city(city)
    joins(:location).where('locations.locality = ?', 'Heidelberg')
  end
  
  def city
    self.location.locality
  end
  
  def location_name
    self.location.name
  end
  
  def time_str
    start_time = self.start_time
    end_time = self.end_time  
    s_day = start_time.day
    s_month = start_time.month
    s_year = start_time.year
    s_hour = start_time.hour
    s_min = start_time.min
    e_day = end_time.day
    e_month = end_time.month
    e_year = end_time.year
    e_hour = end_time.hour
    e_min = end_time.min

    case s_month
    when 1 
      month = "Januar"
    when 2
      month = "Februar"
    when 3
      month = "März"
    when 4
      month = "April"
    when 5
      month = "Mai"
    when 6
      month = "Juni"
    when 7 
      month = "July"
    when 8
      month = "August"
    when 9
      month = "September"
    when 10
      month = "Oktober"
    when 11
      month = "November"
    when 12 
      month = "Dezember"
    end

    if s_day == e_day 
      return "#{s_day}.#{month} um #{s_hour.to_s.rjust(2, '0')}:#{s_min.to_s.rjust(2, '0')} - #{e_hour.to_s.rjust(2, '0')}:#{e_min.to_s.rjust(2, '0')}"
    elsif s_day == e_day - 1 && e_hour < 7
      return "#{s_day}.#{month} um #{s_hour.to_s.rjust(2, '0')}:#{s_min.to_s.rjust(2, '0')} - #{e_hour.to_s.rjust(2, '0')}:#{e_min.to_s.rjust(2, '0')}"
    else
      return "#{s_day}.#{month} um #{s_hour.to_s.rjust(2, '0')}:#{s_min.to_s.rjust(2, '0')} - #{e_day}.#{e_month} um #{e_hour.to_s.rjust(2, '0')}:#{e_min.to_s.rjust(2, '0')}"
    end
  end
  
  
  
end
