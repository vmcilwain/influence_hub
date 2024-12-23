Rails.application.routes.draw do
  root to: 'pages#index'
  
  devise_for :users
  
  resources :campaigns do
    resources :expenses
    resources :tasks do
      patch :update_status, on: :member
    end
  end

  resources :organizations do
    resources :contacts
  end

  resources :documents do
    resources :signatures
  end

  get 'signatures/:external_id/review' => 'signatures#review', as: :review_signature
  put 'signatures/:external_id/sign' => 'signatures#sign', as: :sign_signature
  
  if Rails.env.development?
    get 'prototypes' => 'prototypes#index'
    get 'prototypes/*path' => 'prototypes#show'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
