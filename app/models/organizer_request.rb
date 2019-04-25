class OrganizerRequest < ApplicationRecord
  belongs_to :event
  belongs_to :organizer
end
