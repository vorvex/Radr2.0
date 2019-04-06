class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :locations, dependent: :destroy
  has_many :performers, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :invoices, dependent: :destroy


  
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
