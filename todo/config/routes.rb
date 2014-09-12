Rails.application.routes.draw do
  resources :todos, except: [:new, :edit]

  match "*path", to: "todos#index", via: "get"

  root 'todos#index'

  # get 'todos/index'

  # get 'todos/create'

  # get 'todos/show'

  # get 'todos/update'

  # get 'todos/destroy'

end
