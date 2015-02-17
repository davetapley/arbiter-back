Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :tokens, id: /[A-Za-z0-9\.%]+/, only: [:index, :show, :create, :update]

  resources :domains, only: [:index]

  resources :translations, only: [] do
    member do
      get :resolve
    end
  end

  get ':id', to: 'tokens#resolve'
  root to: 'tokens#none'
end
