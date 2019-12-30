Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :articles, only: [:index, :show]
  root :to => "articles#index"
end
