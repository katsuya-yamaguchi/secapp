Rails.application.routes.draw do
  devise_for :users, controllers: {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"}
  root 'static_pages#index'
  get '/home', to: 'static_pages#home'
  get '/home/:id', to: 'static_pages#home_pagination'

  get '/search', to: 'static_pages#search'
  get '/keyword/:id', to: 'static_pages#pagination'
  get '/tag/:id', to: 'static_pages#pagination'

  get '/mypage', to: 'static_pages#mypage'
  post '/mypage', to: 'static_pages#file_upload'
  get '/mypage/:id', to: 'static_pages#mypage_pagination'

  get '/delete/:id', to: 'static_pages#delete_user', as: 'delete_user'

  get '/video/:id', to: 'static_pages#video'
  delete '/video/:id', to: 'static_pages#video_destroy'

  resources :videos do
    resources :likes, only: [:create, :destroy]
  end

  get '/riyokiyaku', to: 'static_pages#riyokiyaku'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
