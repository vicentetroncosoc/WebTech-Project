Rails.application.routes.draw do
  get "challenge_tags/index"
  get "challenge_tags/show"
  get "user_badges/index"
  get "user_badges/show"
  root "challenges#index"

  resources :challenges
  resources :users
  resources :badges
  resources :tags
  resources :participations
  resources :progress_entries
  resources :notifications,   only: [:index, :show]
  resources :user_badges,     only: [:index, :show]
  resources :challenge_tags,  only: [:index, :show]
end
