class Event < ApplicationRecord
  has_many :tickets, :dependent => :delete_all
  has_many :performer_requests
  has_many :performers, -> { where performer_requests: { accepted: true } } ,
           :through => :performer_requests, 
           :class_name => "Performer", 
           :source => :performer
  has_many :organizer_requests
  has_many :organizers, -> { where organizer_requests: { accepted: true } } ,
           :through => :organizer_requests, 
           :class_name => "Organizer", 
           :source => :organizer
  
  belongs_to :location
  belongs_to :user
  has_many :social_links, :dependent => :delete_all

  has_many_attached :images
  
  def self.categories 
    arr = ['', 'Musik Event', 'Konzert', 'Festival', 'Sport Event', 'Food Event', 'Tanz Event', 'Theater Event']
    return arr
  end
  
  def category_str
    if self.category.nil?
      return "Veranstaltung"
    else
      return self.category
    end
  end
  
  def description_str
    if self.description.nil?
      return "Veranstaltung"
    else
      return self.description
    end
  end
  
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
  
  def similar_events
    Event.find_by_city(self.city)
  end
  
  def performer
    if self.performer_id.nil?
      Performer.none
    else
      Performer.find(self.performer_id)
    end
  end
  
  def next_week?
    days_till = (self.start_time - Time.now) / 86400
    if days_till < 6 && days_till > 0
      return true
    else
      return false
    end
  end
  
  def time_str    
    start_time = self.start_time
    if self.end_time != nil
      end_time = self.end_time
    else
      end_time = self.start_time
    end
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

    case self.start_time.wday
      when 0
        wday = "Sonntag"
      when 1
        wday = "Montag"
      when 2
        wday = "Dienstag"
      when 3
        wday = "Mittwoch"
      when 4
        wday = "Donnerstag"
      when 5
        wday = "Freitag"
      when 6
        wday = "Samstag"
    end
    
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
      if self.next_week?
        return "#{wday} von #{s_hour.to_s.rjust(2, '0')}:#{s_min.to_s.rjust(2, '0')} - #{e_hour.to_s.rjust(2, '0')}:#{e_min.to_s.rjust(2, '0')}"
      else
        return "#{wday[0..1]} #{s_day}. #{month} von #{s_hour.to_s.rjust(2, '0')}:#{s_min.to_s.rjust(2, '0')} - #{e_hour.to_s.rjust(2, '0')}:#{e_min.to_s.rjust(2, '0')}"
      end
    elsif s_day == e_day - 1 && e_hour < 7
      if self.next_week?
        return "#{wday} von #{s_hour.to_s.rjust(2, '0')}:#{s_min.to_s.rjust(2, '0')} - #{e_hour.to_s.rjust(2, '0')}:#{e_min.to_s.rjust(2, '0')}"
      else
        return "#{wday[0..1]} #{s_day}. #{month} von #{s_hour.to_s.rjust(2, '0')}:#{s_min.to_s.rjust(2, '0')} - #{e_hour.to_s.rjust(2, '0')}:#{e_min.to_s.rjust(2, '0')}"
      end
    else
      return "#{wday[0..1]} #{s_day}. #{month} - #{e_day}. #{month}"
    end
  end
  
  def url 
    return '/event/' + self.path 
  end
  
  def path_str
    path = (self.location.locality + " " + self.name).downcase.gsub(" ", "-")
    x = 0
    while !Event.find_by_path(path).nil?
      if x > 0
        path.chop!
      end
      x += 1
      path +=  x.to_s
    end
    
    return path
  end
  
  def page_views
    PageView.where('path = ?', '/event/' + self.path)
  end
  
  def uniq_sessions
    PageView.where('path = ?', '/event/' + self.path).map { |x| x.session_id }.uniq.length
  end
  
end
