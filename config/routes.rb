Rails.application.routes.draw do

  resources :covid_informations
  resources :cities
  devise_for :users
  root to: "home#index"
end
