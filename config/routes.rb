Rails.application.routes.draw do
  root controller: :home, action: :show

  resource :session, only: %i(new create destroy)

  resource :profile, only: %i(show update)

  resources :users, only: :create

  resources :problems, only: %i(index show) do
    resources :submissions, only: %i(index new create)
  end

  resources :tags, only: [] do
    resources :problems, only: :index
  end

  resources :submissions, only: %i(index show)

  namespace :api do
    resources :submissions, only: :index do
      resource :take, only: :create

      resource :release, only: :create
    end
  end
end
