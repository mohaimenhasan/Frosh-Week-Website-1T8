SkuleOrientation::Application.routes.draw do
  root to: 'client#home'

  namespace :api do
    resources :users
    resources :packages

    match 'confirm/:id/:token' => "users#confirm", :as => :confirm_email
  end

  # Forward other routing to be done on client-side.
  match '*path', to: 'client#home'
end
