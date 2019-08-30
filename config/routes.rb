    
Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users,
    path: '',
    path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
    controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  # get '/users/:id', to: 'users#show'
  # /users/3 -> Users controller, show action, params {id: '3'}
  resources :users, only: [:index, :show]
  resources :pages, only: [:index, :show]
  resources :follows, only: [:index] 
      resources :relations, only: [:create, :destroy]
  resources :events, only: [:index, :show, :create, :destroy] do
    resources :likes, only: [:create, :destroy], shallow: true
  end
  post '/users/:id/follow_user' => 'relations#follow_user'

  resources :posts, only: [:index, :show, :create, :destroy] do
    resources :photos, only: [:create]
    resources :loves, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
    resources :bookmarks, only: [:create, :destroy], shallow: true


  end
end