Rails.application.routes.draw do
  get 'users/index'
  get 'top/index'
  get 'logout/logout'
  get 'users/password_reset'
  post 'users/password_reset', to: 'users#password_reset'
  post 'users/ajax_update', to: 'users#ajax_update'
  post 'users/ajax_delete', to: 'users#ajax_delete'
  devise_for :users,
             controllers: {
               confirmations: 'users/confirmations',
               registrations: 'users/registrations',
               sessions: 'users/sessions',
               passwords: 'users/passwords',
             }
  get '/', to: 'home#index'
  resources :memos, only: [:show]
  resources :users, only: %i[index edit update]
  namespace :api, format: 'json' do
    resources :memos, only: %i[index create destroy update]
    resources :infos, only: %i[show update]
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
