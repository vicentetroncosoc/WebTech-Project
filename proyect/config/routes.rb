Rails.application.routes.draw do

  devise_for :users

  get "challenge_tags/index"
  get "challenge_tags/show"
  get "user_badges/index"
  get "user_badges/show"
  root "challenges#index"

  resources :challenges do
  member do
    post   :join
    delete :leave
  end
end
  resources :users
  resources :badges
  resources :tags
  resources :participations
  resources :progress_entries
  resources :notifications,   only: [:index, :show]
  resources :user_badges,     only: [:index, :show]
  resources :challenge_tags,  only: [:index, :show]
end
