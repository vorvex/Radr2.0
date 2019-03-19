class Ticket < ApplicationRecord
  belongs_to :event
  
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
      when "https://schema.org/InStock"
        "Verfügbar"
      when "https://schema.org/SoldOut"
        "<span style='color: #FF2D55 '>Ausverkauft</span>"
      when "https://schema.org/PreOrder"
        "Vorverkauf"
    end
  end
  
  def price_str
    return "%.2f" % self.price
  end
  
end
