class ApplicationController < ActionController::Base
before_action :time_zone
  
  
def time_zone
  Time.zone = "Berlin"
end
  
end
