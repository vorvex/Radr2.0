class Performer < ApplicationRecord
  belongs_to :user
  has_many :social_links, dependent: :destroy
  has_many :events
end
