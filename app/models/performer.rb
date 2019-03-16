class Performer < ApplicationRecord
  belongs_to :user
  has_many :social_links
  has_many :events
end
