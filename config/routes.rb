Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :sessions => "users/sessions", :registrations => "users/registrations"} do
    resources 'users/registrations'
    resources 'users/sessions'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_scope :user do
    authenticated :user do
      root to: "categories#index"
    end

    unauthenticated :user do
      root to: 'devise/sessions#new', :as=> "unauthenticated"
    end
  end

  devise_scope :user do
    get '/sms_verify'=>'users/sessions#sms_verify'
    get '/check_code'=>'users/sessions#check_code'
    get '/verify_mobile'=>'users/sessions#verify_mobile'
  end

  resources :categories

  resources :guests

  resources :ceremonies

  resources :homes do
    collection do
      get 'dashboard'
      get 'search'
      get 'home'
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

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
