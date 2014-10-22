Rails.application.routes.draw do

  resources :users, only: [:index]

  resources :orders do 
    member do 
      post 'assign'
    end
  end

  resources :delivery_men

  resources :restaurants

  devise_for :users, :skip => [:sessions]
  as :user do
    get    'sign_in'   => 'devise/sessions#new',       :as => :new_user_session
    post   'sign_in'   => 'devise/sessions#create',    :as => :user_session
    delete 'sign_out'  => 'devise/sessions#destroy',   :as => :destroy_user_session

    get    'sign_up'  => 'devise/registrations#new'#,  :as => :new_user_registration
  end  

  namespace :api , defaults: {format: :json} do
    namespace :v1 do
      resources :sessions, only: [:create, :destroy] do 
        post 'login' => 'sessions#login'
      end
    end
  end


  root to: 'orders#index'
end
