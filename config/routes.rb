Rails.application.routes.draw do
  get 'top/index'
  devise_for :users   
  get '/', to: 'home#index'
  namespace :api, format: 'json' do
    resources :memos, only: [:index, :create, :destroy, :update]
  end
end
