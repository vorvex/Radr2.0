class Invoice < ApplicationRecord
  belongs_to :user
  
  def date_str
    case self.date.month
      when 1 
        return "Januar" + " " + self.created_at.year.to_s 
      when 2
        return "Februar" + " " + self.created_at.year.to_s
      when 3
        return "März" + " " + self.created_at.year.to_s
      when 4
        return "April" + " " + self.created_at.year.to_s
      when 5
        return "Mai" + " " + self.created_at.year.to_s
      when 6
        return "Juni" + " " + self.created_at.year.to_s
      when 7 
        return "July" + " " + self.created_at.year.to_s
      when 8
        return "August" + " " + self.created_at.year.to_s
      when 9
        return "September" + " " + self.created_at.year.to_s
      when 10
        return "Oktober" + " " + self.created_at.year.to_s
      when 11
        return "November" + " " + self.created_at.year.to_s
      when 12 
        return "Dezember" + " " + self.created_at.year.to_s
    end
      
  end
    
end
