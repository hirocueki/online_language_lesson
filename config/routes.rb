Rails.application.routes.draw do
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

  resources :users
end
