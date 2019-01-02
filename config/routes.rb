Rails.application.routes.draw do
  scope '(:language)', language: /ru|en|uk/ do
    root controller: :home, action: :show

    resource :session, only: %i[new create destroy]

    resource :profile, only: %i[show update]

    resource :avatar, only: %i[create destroy]

    resources :users, only: %i[index create] do
      resources :problems, only: :index

      resources :submissions, only: :index
    end

    resources :problems do
      resources :submissions, only: %i[index new create]
    end

    resources :tags, only: :index do
      resources :problems, only: :index
    end

    resources :submissions, only: %i[index show]

    resources :archives, only: %i[new create]

    resources :compilers, except: :edit

    resources :workers, only: :index

    resources :groups do
      resources :memberships, only: :destroy

      resources :sharings, only: %i(new create)

      resources :invites, only: %i(index new create)

      resources :submissions, :problems, only: :index
    end

    resources :received_invites, only: :index

    resources :invites, only: [] do
      resource :reject, :accept, only: :create, module: :invite
    end

    resources :confirmation_requests, only: %i[index create] do
      resource :reject, :accept, only: :create, module: :confirmation_request
    end
  end

  namespace :api do
    resources :submissions, only: :index do
      resource :take, :release, :fail, only: :create

      resources :logs, only: :create
    end

    resources :problems, only: :show

    resources :results, only: :create

    resources :compilers, :constants, only: :index

    resources :workers, only: :create do
      resource :alive, only: :create

      resource :session, only: %i[create destroy]
    end
  end

  get '/v2/tests/problems.json', to: 'tests#problems'
  get '/v2/tests/statuses.json', to: 'tests#statuses'
  get '/v2/tests/users.json', to: 'tests#users'
  get '/v2/tests/groups.json', to: 'tests#groups'

  resources :tests, only: :create
end
