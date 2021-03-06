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

  namespace :admins do
    resources :reservations, only: %i[index]
    resources :monthly_graphs, only: %i[index show] do
      resources :daily_graphs, only: %i[index]
    end
    resources :language_graphs, only: %i[index show]
  end

  namespace :users do
    resources :lessons, only: [:index]
    resources :reservations, only: %i[index new create]
    resources :charges, only: %i[new create]
    resources :subscriptions, only: %i[new create edit update]
  end

  namespace :teachers do
    resources :reservations, only: [:index]
    resources :lessons do
      resources :reports, only: %i[show new create edit update destroy]
    end
    resources :languages
    resources :reports, only: %i[index]
    resources :multi_lesson_registers, only: %i[new create]
    end


  devise_scope :teacher do
    resources :teachers, only: [] do
      get "masquerade", to: "teachers/sessions#masquerade_sign_in", on: :member
    end
    get "back_to_owner", to: "teachers/sessions#back_to_owner"
  end

  resources :users, only: :show do
    resources :reports, only: :index, controller: "users/reports"
  end

  resources :teachers, only: %i[index destroy] do
    get :profile, action: :profile, on: :collection
  end

  resources :lesson_feedbacks


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/lo'
  end
end
