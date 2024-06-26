Rails.application.routes.draw do
  scope '(:language)', language: /ru|en|uk/ do
    root controller: :home, action: :show

    resource :session, only: %i[new create destroy]

    resource :profile, only: %i[show update]

    resource :avatar, only: %i[create destroy]

    resources :users, only: %i[index create], constraints: { id: /\d+/ } do
      resources :problems, only: :index, constraints: { id: /\d+[\-\w]*/ } do
        resources :submissions, only: :index
      end

      resources :submissions, only: :index
    end

    resources :problems, constraints: { id: /\d+[\-\w]*/ } do
      resources :submissions, only: %i[index create]
    end

    resources :tags, only: :index do
      resources :problems, only: :index
    end

    resources :submissions, only: %i[index show destroy] do
      resource :retest, only: :create, module: :submission
    end

    resources :archives, only: %i[new create]

    resources :compilers, except: :show

    resources :workers, only: %i[index destroy]

    resources :contests do
      resources :contest_memberships, except: %i[show edit], shallow: true

      resources :sharings, only: %i[new create]

      resources :submissions, :problems, only: :index

      resource :standing, only: :show
    end

    resources :groups do
      resources :group_memberships, except: %i[show edit], shallow: true

      resources :submissions, only: :index
    end

    resources :confirmation_requests, only: %i[index create] do
      resource :reject, :accept, only: :create, module: :confirmation_request
    end

    resources :memberships, :contest_memberships, :group_memberships, only: :index

    resource :password_recovery, only: %i[new create]

    resource :password, only: %i[edit update]
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

    resources :test_libs, only: %i[show create], param: :version, constraints: { version: /((\d+)(\.\d+)*|latest)/ }
  end
end
