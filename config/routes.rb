SkuleOrientation::Application.routes.draw do
  root to: 'client#home'

  namespace :api do

    scope constraints: lambda{|req| !req.session[:access_token].blank? } do
      scope module: 'admin' do
        resources :users
        resources :packages
        resources :groups
        resources :admins
      end
    end

    resources :users
    resources :packages
    resources :groups
    resources :admins
  end

  match '/auth', to: 'oauth#callback'

  # Forward other routing to be done on client-side.
  match '*path', to: 'client#home'
end
