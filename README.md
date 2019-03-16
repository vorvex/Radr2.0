# Radr 2.0

PG Fehler Korrektur:

Schritt 1:  
sudo apt-get install libpq-dev  

Schritt 2:  
bundle install  

Datenbanken:  
User, Locations, Events, Performer, OpeningHours, Tickets, SocialLinks  

User _has many_ Locations  
User _has many_ Performer  
User:
* devise   
* string "plan"   


Location _has many_ OpeningHours  
Location _has many_ Events  
Location _belongs to_ User  
Location _has attachment_ Logo  
Location _has attachments_ Images  
Location _has many_ SocialLinks  
Location:
* integer "user_id"  
* string "name"  
* string "type"  
* string "formatted_address"  
* string "facebook_page"  
* string "route"  
* string "street_number"  
* string "postal_code"  
* string "locality"  
* string "place_id"  
* string "lat"  
* string "lng"  

Event _has one_ Performer  
Event _has one_ Location  
Event _has many_ Tickets  
Event:
* integer "location_id"  
* integer "performer_id"  
* string "name"  
* string "category"  
* string "description"  
* datetime "start_time"  
* datetime "end_time"  
* string "pathname", default: "/"  
* string "facebook_event"  
* string "image_url"  
* string "start_date"  
* string "end_date"  
* string "yt-video"  
* sting "soundcloud"  
* string "status"  

Performer _belongs to_ User  
Location _has attachment_ Profilbild  
Performer:
* string "name"  
* string "category"  
* string "description"  

OpeningHours _belongs to_ Location  
OpeningHours:
* integer "location_id"  
* date "date"  
* integer "week_day"  
* time "start_time"  
* time "end_time"  

Ticket _belongs to_ Location  
Ticket:
* integer "location_id"  
* string "name"  
* string "url"  
* string "status"  

SocialLinks:  
* integer "location_id"  
* integer "performer_id"  
* string "channel"  
* string "url"  