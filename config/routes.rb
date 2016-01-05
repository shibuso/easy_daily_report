Rails.application.routes.draw do

  root 'page#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }, skip: [:sessions]
  as :user do
    get 'sign_up' => 'users/registrations#custom_new', :as => :user_signup
    post 'user' => 'users/registrations#custom_create', :as => :user_registration
    get 'sign_in' => 'page#index', :as => :new_user_session
    post 'sign_in' => 'users/sessions#create', :as => :user_session
    delete 'sign_out' => 'users/sessions#destroy', :as => :destroy_user_session
  end

  resources :reports do
    put :confirm, on: :member
    patch :confirm, on: :member
    post :confirm, on: :collection
    get :drafts, on: :collection
  end
  resources :projects
  resources :customers, except: [:show]
  resources :users, only: [:index]
end
