Rails.application.routes.draw do

  root "documents#index"

  resources :documents

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
