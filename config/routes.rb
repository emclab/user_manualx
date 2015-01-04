UserManualx::Engine.routes.draw do

  resources :manuals do
    collection do
      get :search
      get :search_results
    end
  end
  root :to => 'manuals#index'
end
