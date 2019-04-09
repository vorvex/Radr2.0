class Session < ApplicationRecord
  has_secure_token
  
  has_many :page_views
  
end
