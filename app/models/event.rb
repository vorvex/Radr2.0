class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_one :performer
  has_one :location
end
