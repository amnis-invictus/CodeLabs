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
      resources :submissions, only: %i[index create]
    end

    resources :tags, only: :index do
      resources :problems, only: :index
    end

    resources :submissions, only: %i[index show]

    resources :archives, only: %i[new create]

    resources :compilers, except: :show

    resources :workers, only: %i[index destroy]

    resources :groups do
      resources :memberships, only: :destroy

      resources :sharings, only: %i[new create]

      resources :invites, only: %i[index new create]

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
      resources :take, :release, :fail, only: :create, module: :submission

      resources :logs, only: :create
    end

    resources :problems, only: :show

    resources :results, only: :create

    resources :compilers, :constants, only: :index

    resources :workers, only: %i[create update]
  end
end
