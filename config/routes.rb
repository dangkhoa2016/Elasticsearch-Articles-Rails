Rails.application.routes.draw do
  get '/search', to: 'search#index', as: 'search'
  get '/sections', to: 'categories#sections', as: 'sections'
  get '/writers', to: 'authors#writers', as: 'writers'

  resources :authorships
  resources :authors do
    collection { get :search }
  end
  resources :categories do
    collection { get :search }
  end
  resources :comments
  resources :articles do
    collection { get :search }
  end

  root to: 'search#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
