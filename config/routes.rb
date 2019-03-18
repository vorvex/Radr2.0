Rails.application.routes.draw do
  
  namespace :api do
    resources :user do
    end
  end
  
  root 'dashboard#index'
  
  get 'einstellungen' => 'dashboard#settings'
  get 'neue-location' => 'dashboard#new_location'
  get 'neuer-performer' =>'dashboard#new_performer'
  get 'public_neues-event' => 'dashboard#new_event'
  
  post 'event/create' => 'event#create'
  post 'location/create' => 'location#create'
  post 'opening_hour/create' => 'opening_hour#create'
  post 'social_link/create' => 'social_link#create'
  post 'ticket/create' => 'ticket#create'
  post 'performer/create' => 'performer#create'
  
  put 'event/edit' => 'event#edit'
  put 'location/edit' => 'location#edit'
  put 'opening_hour/edit' => 'opening_hour#edit'
  put 'social_link/edit' => 'social_link#edit'
  put 'ticket/edit' => 'ticket#edit'
  put 'performer/edit' => 'performer#edit'
  
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
  get 'event/:city/:name/' => 'public_view#event'
  
end
