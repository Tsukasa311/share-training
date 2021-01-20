Rails.application.routes.draw do
  root to: "posts#home"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  resources :users, only: [:new, :show, :edit, :update]
  resources :posts, only: [:new, :index, :create, :show, :destroy] do
    collection do
      get 'search'
      get 'tag_search'
    end
  end
end
