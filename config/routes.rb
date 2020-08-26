Rails.application.routes.draw do
  resources :covid_informations do
    collection { post :import }
  end
  resources :cities
  devise_for :users
  resources :informations do
    collection { post :import }
  end

  get 'contato', to: 'home#contact', as: :contact

  root to: 'home#index'
end
