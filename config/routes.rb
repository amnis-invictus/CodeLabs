Rails.application.routes.draw do
  root controller: :home, action: :show

  resource :session, only: %i(new create destroy)

  resource :profile, only: :show

  resources :users, only: :create

  resources :problems, only: %i(index show) do
    resources :submissions, only: %i(index new create)
  end

  resources :submissions, only: %i(index show)
end
