Rails.application.routes.draw do
  devise_for :users
  root 'expeditions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resource :profile, only: [:show, :update]
  end

  resources :friendships, only: [:create]
  patch 'friendships/accept_friend' => 'friendships#accept_friend', as: :accept_friend
  patch 'friendships/reject_friend' => 'friendships#reject_friend', as: :reject_friend

  resources :expeditions do
    resources :coordinates, only: [:update]
    post 'journeys/requesting' => 'journeys#requesting', as: :requesting
    post 'journeys/approve' => 'journeys#approve', as: :request_approval
  end
  get 'expeditions/:id/markers' => 'expeditions#markers', as: :expedition_markers

end
