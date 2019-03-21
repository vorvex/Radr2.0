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
  
  post 'event/create' => 'event#create'  
  
  post 'location/create' => 'location#create_location1'
  patch 'location/create2/:id' =>  'location#create_location2', as: :create_location2
  patch 'location/create3/:id' =>  'location#create_location3', as: :create_location3
  
  post 'opening_hour/create' => 'opening_hour#create'
  post 'social_link/create' => 'social_link#create'
  post 'ticket/create' => 'ticket#create'
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
  delete 'ticket/delete' => 'ticket#delete'
  delete 'performer/delete' => 'performer#delete'
  
  devise_for :users

  # Event, Location & Performer Views
  
  get 'location/:city/:name' => 'public_view#location'
  get 'performer/:id' => 'public_view#performer'
  get 'event/:city/:id/:name/' => 'public_view#event'
  get 'event/:id/tickets' => 'public_view#tickets'
  
end
