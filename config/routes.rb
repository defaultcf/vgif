# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks' }
  get '@:username', to: 'user/info#show', as: 'user'
  namespace :user do
    get 'recommend', to: 'recommend#show'
    get 'edit', to: 'info#edit'
    patch 'update', to: 'info#update'
    delete 'delete', to: 'info#delete'
  end

  namespace :api do
    get 'gifscom/fetch_meta'
  end

  resources :gifs
  scope 'tags' do
    get '/', to: 'tags#index', as: :tags
    get ':tag_name', to: 'tags#show', as: :tag
  end
end
