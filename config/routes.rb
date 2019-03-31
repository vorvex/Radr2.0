Rails.application.routes.draw do
  
  namespace :api do
    resources :user do
    end
  end
  
  root 'dashboard#index'
  
  get 'first_login' => 'dashboard#first_login', as: :first_login
  
  get 'l/show/:id' => 'dashboard#show_location', as: :show_location
  get 'p/show/:id' => 'dashboard#show_performer', as: :show_performer
  
  get 'l/:id/edit_images' => 'location#edit_images'
  get 'p/:id/edit_images' => 'performer#edit_images'
  get 'e/:id/edit_images' => 'event#edit_images'
  
  get 'l/:id/events' => 'location#events'
  get 'p/:id/events' => 'performer#events'
  
  get 'l/:id/edit_informations' => 'location#edit_informations'
  get 'p/:id/edit_informations' => 'performer#edit_informations'
  get 'e/:id/edit' => 'event#edit'

  patch 'l/:id/edit_informations' => 'location#update_informations', as: :edit_location_informations
  patch 'p/:id/edit_informations' => 'performer#update_informations', as: :edit_performer_informations
  patch 'e/:id/edit' => 'event#update', as: :update_event
  
  get 'l/:id/share' => 'location#share'
  get 'p/:id/share' => 'performer#share'
  get 'e/:id/share' => 'event#share'
  
  get 'l/:id/social_links' => 'location#social_links'
  get 'p/:id/social_links' => 'performer#social_links'
  get 'e/:id/social_links' => 'event#social_links'
  
  patch 'l/:id/social_links' => 'location#edit_social_links', as: :edit_location_social_links
  patch 'p/:id/social_links' => 'performer#edit_social_links', as: :edit_performer_social_links
  patch 'e/:id/social_links' => 'event#edit_social_links', as: :edit_event_social_links
  
  get 'l/:id/opening_hours' => 'location#opening_hours'
  patch 'l/:id/opening_hours' => 'location#update_opening_hours', as: :update_opening_hours
  
  get 'einstellungen' => 'dashboard#settings'
  get 'neue-location' => 'dashboard#new_location'
  get 'neuer-performer' =>'dashboard#new_performer'
  get 'neues-event' => 'dashboard#new_event'
  
  get 'event-bearbeiten/:id' => 'dashboard#edit_event'
  get 'performer-bearbeiten/:id' => 'dashboard#edit_performer'

  post 'event/create' => 'event#create_event1', as: :create_event1
  post 'event/:id/add_images' =>  'event#add_images'
  patch 'event/create3/:id' =>  'event#create_event3', as: :create_event3
  
  post 'create-ticket' =>  'ticket#create', as: :create_ticket
  
  post 'create-link' =>  'social_link#create', as: :create_link
  
  post 'location/create' => 'location#create_location1', as: :create_location1
  post 'location/:id/add_images' =>  'location#add_images'
  patch 'location/create3/:id' =>  'location#create_location3', as: :create_location3
  
  post 'performer/create' => 'performer#create_performer1', as: :create_performer1
  post 'performer/:id/add_image' =>  'performer#add_image'
  
  post 'opening_hour/create' => 'opening_hour#create'
  post 'social_link/create' => 'social_link#create'
  post 'ticket/create' => 'ticket#create'
  
  get 'performer/search' => 'event#search_performer'
  post 'performer/invite' => 'event#invite_performer', as: :invite_performer
  post 'performer/create' => 'performer#create'
  
  patch 'event/edit/:id' => 'event#edit', as: :edit_event
  patch 'location/edit/:id' => 'location#edit'
  patch 'opening_hour/edit/:id' => 'opening_hour#edit'
  patch 'social_link/edit/:id' => 'social_link#edit'
  patch 'ticket/edit/:id' => 'ticket#edit'
  patch 'performer/edit/:id' => 'performer#edit', as: :edit_performer
  
  delete 'event/delete' => 'event#delete'
  delete 'location/delete' => 'location#delete'
  delete 'delete_image/:id' => 'dashboard#delete_image', as: :delete_image
  delete 'opening_hour/delete' => 'opening_hour#delete'
  delete 'social_link/delete' => 'social_link#destroy', as: :destroy_link
  delete 'ticket/delete' => 'ticket#destroy', as: :destroy_ticket
  delete 'performer/delete' => 'performer#delete'
  
  devise_for :users

  # Event, Location & Performer Views
  
  get 'location/:path' => 'public_view#location'
  get 'performer/:path' => 'public_view#performer'
  get 'event/:path' => 'public_view#event'
  get 'event/:path/tickets' => 'public_view#tickets'
  
end
