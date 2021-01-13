Rails.application.routes.draw do
  root to: "posts#home"
  devise_for :users
end
