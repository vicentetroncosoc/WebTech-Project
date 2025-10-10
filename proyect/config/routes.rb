Rails.application.routes.draw do
  get "challenge_tags/index"
  get "challenge_tags/show"
  get "user_badges/index"
  get "user_badges/show"
  root "challenges#index"

  resources :challenges,      only: [:index, :show]
  resources :users,           only: [:index, :show]
  resources :badges,          only: [:index, :show]
  resources :tags,            only: [:index, :show]
  resources :participations,  only: [:index, :show]
  resources :progress_entries,only: [:index, :show]
  resources :notifications,   only: [:index, :show]
  resources :user_badges,     only: [:index, :show]
  resources :challenge_tags,  only: [:index, :show]
end


