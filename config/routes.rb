Rails.application.routes.draw do
  devise_for :owner, controllers: {
    registrations: 'owners/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  resources :owners, only: [:index] do
    member do
      get '/unsubscribe' => 'owners#unsubscribe'
      delete '/withdraw' => 'owners#withdraw'
    end
  end
  resources :pets, only: [:index, :show, :edit, :update] do
    resource :pet_personalities, only: [:create, :update]
    resource :chats, only: [:show, :create]
    resources :relationships, only: [:create, :destroy]
  end
  resources :diaries, only: [:index, :create, :destroy]
  resources :memories
  resources :diary_comments, only: [:create, :destroy]
  resources :diary_favorites, only: [:create, :destroy]
  resources :notifications, only: :index
end
