class Ticket < ApplicationRecord
  belongs_to :event
  
  def self.stati 
    arr = ['Vorverkauf', 'Verfügbar', 'Abendkasse', 'Ausverkauft']
    
    return arr
  end
  
  def status_schema
    case self.status
      when 'Verfügbar'
        return "https://schema.org/InStock"
      when 'Abendkasse'
        return "https://schema.org/InStock"
      when 'Ausverkauft'
        return "https://schema.org/SoldOut"
      when 'Vorverkauf'
        return "https://schema.org/PreOrder"
    end
  end
  
  def status_html
    case self.status
      when "Ausverkauft"
        "<span style='color: #FF2D55 '>Ausverkauft</span>"
    else
      return self.status
    end
  end
  
  def price_str
    if !self.price.nil?
      return "%.2f" % self.price
    else
      return "Kostenlos" 
    end
  end
  
end
