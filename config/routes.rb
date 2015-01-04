UserManualx::Engine.routes.draw do

  resources :manuals
  root :to => 'manuals#index'
end
