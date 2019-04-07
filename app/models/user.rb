class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :locations, :dependent => :delete_all
  has_many :performers, :dependent => :delete_all
  has_many :events, :dependent => :delete_all
  has_many :invoices, :dependent => :delete_all


  
  def plan_str
    case self.plan
      when "free"
        return "Kostenlos"
      when "Gold"
        return "Gold"
      when "Platin"
        return "Platin"
    end
  end
  
end
