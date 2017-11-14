Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  get '/riyokiyaku', to: 'static_pages#riyokiyaku'
  get '/courses', to: 'static_pages#courses'
  get '/courses/:id', to: 'static_pages#list'
  get '/video/:id', to: 'static_pages#list_video'
  get '/video/list/:id', to: 'static_pages#video'
  get '/pricing', to: 'static_pages#pricing'
  
  get '/admin', to: 'admins#index'
  post '/admin', to: 'admins#file_upload'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
