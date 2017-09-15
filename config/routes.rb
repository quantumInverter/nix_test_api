Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

      resources :users, exept: :index
      resources :questions, shallow: true do
        resources :comments, except: :show do
          resources :votes, only: [:create, :update]
        end
        resources :votes, only: [:create, :update]
      end

      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
  end
end
