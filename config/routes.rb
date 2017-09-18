Rails.application.routes.draw do
  devise_for :users, path: 'api/v1', controllers: {
      passwords: 'api/v1/users/passwords',
      omniauth_callbacks: 'api/v1/users/omniauth_callbacks'
  }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
    namespace :v1 do
      match '/sign_in', to: 'users#sign_in',  via: :post

      resources :users, except: :index
      resources :tags,  only:   :index
      resources :questions, shallow: true do
        resources :comments, except: :show do
          resources :votes, only: [:create, :update]
        end
        resources :votes, only: [:create, :update]
      end

      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end

  match '/(*url)',              to: 'application#not_found',  via: :all
end
