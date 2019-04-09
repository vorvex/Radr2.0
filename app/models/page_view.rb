class PageView < ApplicationRecord

  has_one :session 
  belongs_to :user 

end
