Rails.application.routes.draw do
  resources :artists
  resource :session
  resources :playlists
  resources :users
  resources :songs
  resources :bookmarks

  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  root 'users#new'
end
