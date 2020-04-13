Rails.application.routes.draw do

  devise_for :users
  get 'graphics/index'
  root to: "graphics#index"
end
