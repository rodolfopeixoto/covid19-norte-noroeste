Rails.application.routes.draw do
  resources :covid_informations do
    collection { post :import }
  end
  resources :cities
  devise_for :users
  resources :informations do
    collection { post :import }
  end
  root to: 'home#index'
end
