class Ticket < ApplicationRecord
  belongs_to :event
  
  def self.stati 
    arr = ['Vorverkauf', 'Verfügbar', 'Abendkasse', 'Ausverkauft']
    
    return arr
  end
  
  def status_str
    case self.status
      when "https://schema.org/InStock"
        "Verfügbar"
      when "https://schema.org/SoldOut"
        "Ausverkauft"
      when "https://schema.org/PreOrder"
        "Vorverkauf"
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
