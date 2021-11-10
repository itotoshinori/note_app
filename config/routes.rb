Rails.application.routes.draw do
  get 'users/index'
  get 'top/index'
  get 'logout/logout'
  get 'users/passwordreset'
  post 'users/ajax_update', to: 'users#ajax_update'
  post 'users/ajax_delete', to: 'users#ajax_delete'
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
  get '/', to: 'home#index'
  resources :memos, only: [:show]
  resources :users, only: [:index,:edit,:update]
  namespace :api, format: 'json' do
    resources :memos, only: [:index, :create, :destroy, :update]
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
