class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :locations, dependent: :destroy
  has_many :performers, dependent: :destroy

  def events
    arr = Array.new
    self.locations.each do |location|
      arr << location.events
    end
    self.performers.each do |performer|
      arr << performer.events
    end
    return arr.flatten
  end
  
end
