Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :gifs
  scope 'tags' do
    get '/', to: 'tags#index', as: :tags
    get ':tag_name', to: 'tags#show', as: :tag
  end
end
