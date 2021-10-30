Rails.application.routes.draw do
  get 'top/index'
  get 'logout/logout'
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
  get '/', to: 'home#index'
  resources :memos, only: [:show]
  namespace :api, format: 'json' do
    resources :memos, only: [:index, :create, :destroy, :update]
  end
end
