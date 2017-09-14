Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :votes
      resources :comments
      resources :questions
      mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end
end
