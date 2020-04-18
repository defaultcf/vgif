Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks' }
  get '@:username', to: 'user/info#show', as: 'user'
  namespace :user do
    get 'edit', to: 'info#edit'
    patch '/', to: 'info#update'
  end

  resources :gifs
  scope 'tags' do
    get '/', to: 'tags#index', as: :tags
    get ':tag_name', to: 'tags#show', as: :tag
  end
end
