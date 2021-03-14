Rails.application.routes.draw do
  devise_for :owner
  devise_scope :owner do
    post 'owners/guest_sign_in', to: 'owners/sessions#new_guest'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'about' => 'homes#about'
  resources :owners, only: [:destroy] do
    member do
      get '/unsubscribe' => 'owners#unsubscribe'
    end
  end
  resources :pets, only: [:index, :show, :edit, :update] do
    resource :pet_personalities, only: [:create, :update]
    resource :chats, only: [:show, :create]
    resources :pet_rooms, only: [:index]
    resources :relationships, only: [:create, :destroy]
  end
  resources :diaries, only: [:index, :show, :create, :destroy]
  resources :diary_comments, only: [:create, :destroy]
  resources :memories
  resources :memory_comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
  resources :notifications, only: :index
  get 'search' => 'searches#search'
  get 'inquiry' => 'inquiries#new'
  get 'inquiry/confirm' => 'inquiries#confirm'
  get 'inquiry/thanks' => 'inquiries#thanks'
end
