Rails.application.routes.draw do

  
  mount UserManualx::Engine => "/user_manualx"
  mount Authentify::Engine => '/authentify'
  mount Commonx::Engine => '/common'
  mount Searchx::Engine => '/search'
  
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
  get '/help', :to => 'user_manualx/manuals#index'
end
