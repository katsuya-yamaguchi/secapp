Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  root 'static_pages#index'

  get '/riyokiyaku', to: 'static_pages#riyokiyaku'
  get '/courses', to: 'static_pages#courses'
  get '/courses/:id', to: 'static_pages#list_courses'
  get '/courses/:id/video', to: 'static_pages#list_videos'
  get '/courses/:id/video/:video_perm', to: 'static_pages#videos'
  
  get '/admins', to: 'admins#index'
  post '/admins', to: 'admins#file_upload'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
