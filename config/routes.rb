Rails.application.routes.draw do
  
  namespace :api do
    resources :user do
    end
  end
  
  root 'dashboard#index'
  
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
  
  post 'location/create' => 'location#create_location1', as: :create_location1
  post 'location/:id/add_images' =>  'location#add_images'
  patch 'location/create3/:id' =>  'location#create_location3', as: :create_location3
  
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
  delete 'opening_hour/delete' => 'opening_hour#delete'
  delete 'social_link/delete' => 'social_link#delete'
  delete 'ticket/delete' => 'ticket#destroy', as: :destroy_ticket
  delete 'performer/delete' => 'performer#delete'
  
  devise_for :users

  # Event, Location & Performer Views
  
  get 'location/:city/:name' => 'public_view#location'
  get 'performer/:id' => 'public_view#performer'
  get 'event/:city/:id/:name/' => 'public_view#event'
  get 'event/:id/tickets' => 'public_view#tickets'
  
end
