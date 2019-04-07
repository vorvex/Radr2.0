class Invoice < ApplicationRecord
  belongs_to :user
  
  def date_str
    case self.date.month
      when 1 
        return "Januar" + " " + self.created_at.year 
      when 2
        return "Februar" + " " + self.created_at.year
      when 3
        return "März" + " " + self.created_at.year
      when 4
        return "April" + " " + self.created_at.year
      when 5
        return "Mai" + " " + self.created_at.year
      when 6
        return "Juni" + " " + self.created_at.year
      when 7 
        return "July" + " " + self.created_at.year
      when 8
        return "August" + " " + self.created_at.year
      when 9
        return "September" + " " + self.created_at.year
      when 10
        return "Oktober" + " " + self.created_at.year
      when 11
        return "November" + " " + self.created_at.year
      when 12 
        return "Dezember" + " " + self.created_at.year
    end
      
  end
    
end
