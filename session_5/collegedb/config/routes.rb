Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :assignments, only: [:update, :destroy]
  resources :courses
  resources :students
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
