Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  require 'subdomain'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :sessions => "users/sessions", :registrations => "users/registrations",
                                       :confirmations => "users/confirmations", :passwords => "users/passwords"} do
    resources 'users/registrations'
    resources 'users/sessions'
    resources 'users/passwords'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_scope :user do
    constraints(Subdomain) do
      get '/' => 'subsites#show'
    end

    authenticated :user do
      root to: "categories#index"
    end

    unauthenticated :user do
      root to: 'homes#search_page', :as=> "unauthenticated"
    end
  end

  devise_scope :user do
    get '/sms_verify'=>'users/sessions#sms_verify'
    get '/check_code'=>'users/sessions#check_code'
    get '/verify_mobile'=>'users/sessions#verify_mobile'
    get '/get_twitter_email'=>'users/sessions#get_twitter_email'
    get '/update_twitter_email'=>'users/sessions#update_twitter_email'
  end

  resources :categories do
    collection do
      get 'save_visitor'
      get 'sms_verify'
      get 'check_code'
      get 'autocomplete_locations'
      post 'save_references'
    end
  end

  resources :guests

  resources :ceremonies

  resources :homes do
    collection do
      get 'dashboard'
      get 'search'
      get 'index'
      get 'search_page'=>'homes#search_page', as: :search_page
      get 'search_results'
    end
  end

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end

  resources :messages, only: [:new, :create]

  resources :galleries do
    member do
      delete :delete_photo
      delete :delete_video
      delete :delete_video_url
    end
  end

  resources :profile_pics

  #resources :user_keywords

  resources :subsites

  resources :wishlists

  resources :import_contacts do
    collection do
      get 'authorise'
      get 'authenticate'
      get 'send_invite'
      get 'multiple_mail'
      get 'invitation_mail'
    end
  end

  get ':page', :to => 'homes#show', :page => /contact_us|privacy_policy|disclaimer/, :as => :page
end
