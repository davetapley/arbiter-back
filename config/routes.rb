Rails.application.routes.draw do
  resources :tokens, only: [:index, :show]

  resources :translations, only: [] do
    member do
      get :resolve
    end
  end

  get ':id', to: 'translations#resolve'
end
