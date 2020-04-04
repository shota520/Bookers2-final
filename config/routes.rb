Rails.application.routes.draw do

	root to: 'home#top'

  devise_for :users

  resources :books

  resources :users

  get '/' => 'home#top',as:"home_top"

  get 'home/about' => 'home#about',as:"home_about"





end