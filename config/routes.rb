Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "homes#index"

  devise_for :teachers, controllers: {
      sessions:      'teachers/sessions',
      passwords:     'teachers/passwords',
      registrations: 'teachers/registrations'
  }

  devise_for :users, controllers: {
      sessions:      'users/sessions',
      passwords:     'users/passwords',
      registrations: 'users/registrations'
  }


  namespace :users do
    resources :lessons, only: [:index]
    resources :reservations, only: %i[index new create]
  end

  #resources :users do
  #  collection do
  #    get :reservations
  #  end
  #end

  resources :teachers do
    collection do
      get :reservations
    end
    member do
      get :sign_in
    end
  end


  resources :lessons

  resources :reservations, only: %i[index show new create] do
    resources :lessons, controller: "reservations/lessons"
  end

  resources :languages, only: %i[index show] do
    resources :lessons, only: %i[index], controller: "languages/lessons"
    resources :reservations, only: %i[index]
  end

  resources :charges
end
