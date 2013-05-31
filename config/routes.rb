SkuleOrientation::Application.routes.draw do
  root to: 'client#home'

  namespace :api do
    resources :users
  end

  # Forward other routing to be done on client-side.
  match '*path', to: 'client#home'
end
