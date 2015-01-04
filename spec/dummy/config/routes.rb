Rails.application.routes.draw do

  get "user_menus/index"

  mount UserManualx::Engine => "/user_manualx"
  mount Authentify::Engine => '/authentify'
  mount Commonx::Engine => '/common'
  mount Searchx::Engine => '/search'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
  match '/help', :to => 'user_manualx::manuals#index'
end
