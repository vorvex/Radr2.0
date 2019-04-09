class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :locations, :dependent => :delete_all
  has_many :performers, :dependent => :delete_all
  has_many :events, :dependent => :delete_all
  has_many :invoices, :dependent => :delete_all
  has_many :sessions, :dependent => :delete_all
  has_many :page_views, :dependent => :delete_all

  def max_files
    case self.plan
      when "free"
        return 3
      when "Gold"
        return 10
      when "Platin"
        return 20
    end
      
  end
  
  def plan_str
    case self.plan
      when "free"
        return "Kostenlos"
    else
      return self.plan
    end
  end
  
end
