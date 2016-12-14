Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: 'users/sessions' }

  root 'expeditions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resource :profile, only: [:show, :update]
  end

  resources :messages
  get 'messages/subscribe' => 'messages#subscribe', as: :pubnub_subscribe

  resources :friendships, only: [:create], defaults: { format: :json }
  patch 'friendships/accept_friend' => 'friendships#accept_friend', as: :accept_friend
  patch 'friendships/reject_friend' => 'friendships#reject_friend', as: :reject_friend

  get 'expeditions/:id/markers' => 'expeditions#markers', as: :expedition_markers
  resources :expeditions do
    resources :coordinates, only: [:update]
    resources :chats
    post 'journeys/requesting' => 'journeys#requesting', as: :requesting
    patch 'journeys/approve' => 'journeys#approve', as: :request_approval
    patch 'journeys/deny' => 'journeys#deny', as: :request_denial
    post 'journeys/inviting' => 'journeys#inviting', as: :invite_friends
    patch 'journeys/accepting' => 'journeys#accepting', as: :accept_invite
  end

end
