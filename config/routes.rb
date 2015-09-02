SkuleOrientation::Application.routes.draw do
  root to: 'client#home'

  namespace :api do

    scope constraints: lambda{|req| Rails.application.config.offline_mode || !req.session[:access_token].blank? } do
      scope module: 'admin' do
        match '/users/:id/send_confirmation_email', to: 'users#send_confirmation_email'
        match '/users/:id/send_receipt_email', to: 'users#send_receipt_email'
        match '/leedurs/:id/send_confirmation_email', to: 'leedurs#send_confirmation_email'
        match '/leedurs/:id/send_receipt_email', to: 'leedurs#send_receipt_email'
        resources :users
        resources :packages
        resources :groups
        resources :admins
        resources :package_items
        resources :hhf_packages
        resources :hhf_package_items
        resources :leedurs
      end
    end

    resources :users
    resources :packages
    resources :groups
    resources :admins
    resources :package_items
    resources :hhf_packages
    resources :hhf_package_items
    resources :leedurs
  end

  match '/auth', to: 'oauth#callback'

  # Forward other routing to be done on client-side.
  match '*path', to: 'client#home'
end
