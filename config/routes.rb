SkuleOrientation::Application.routes.draw do
  root to: 'client#home'

  namespace :api do
    resources :users
    resources :packages
    resources :groups

    namespace :admin do
      resources :users
      resources :packages do
        resources :users
      end
      resources :groups do
        resources :users
      end
    end
  end

  # Forward other routing to be done on client-side.
  match '*path', to: 'client#home'
end
