SkuleOrientation::Application.routes.draw do
  root to: 'client#home'

  # TODO(johnliu): API json routes.

  # Forward other routing to be done on client-side.
  match '*path', to: 'client#home'
end
