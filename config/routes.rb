Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :tokens, id: /[^\/]+/, only: [:index, :show, :create, :update] do
    member do
      get 'available'
    end
  end

  resources :domains, only: [:index]

  resources :translations, only: [] do
    member do
      get :resolve
    end
  end

  get ':id', to: 'tokens#resolve'
  root to: 'tokens#none'
end
