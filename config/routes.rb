Rails.application.routes.draw do
  devise_for :users
  root 'expeditions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resource :profile, only: [:show, :update]
  end

  resources :expeditions do
    resources :coordinates, only: [:update]
  end

  get 'expeditions/:id/markers' => 'expeditions#markers', as: :expedition_markers
end
