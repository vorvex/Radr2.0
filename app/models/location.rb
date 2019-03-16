class Location < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :opening_hours
  has_many :social_links
end
