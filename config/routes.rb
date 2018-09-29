Rails.application.routes.draw do
  root controller: :home, action: :show

  resource :session, only: %i(new create destroy)

  resource :profile, only: %i(show update)

  resources :users, only: :create

  resources :problems, only: %i(index show new create) do
    resources :submissions, only: %i(index new create)
  end

  resources :tags, only: [] do
    resources :problems, only: :index
  end

  resources :submissions, only: %i(index show)

  namespace :api do
    resources :submissions, only: :index do
      resource :take, :release, :fail, only: :create

      resources :logs, only: :create
    end

    resources :problems, only: :show

    resources :results, only: :create

    resources :compilers, :constants, only: :index
  end

  get '/v2/problems/new', to: "problems#new-online"

  get '/v2/users/confirm', to: "users#confirm"

  get '/v2/tests/problems.json', to: 'tests#problems'
  get '/v2/tests/statuses.json', to: 'tests#statuses'
  get '/v2/tests/users.json', to: 'tests#users'
  get '/v2/tests/groups.json', to: 'tests#groups'

  resources :tests, only: :create
end
