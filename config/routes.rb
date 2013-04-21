SkuleOrientation::Application.routes.draw do
  root to: 'client#home'

  # Catch-all router.
  match '*path', to: 'client#home'
end
