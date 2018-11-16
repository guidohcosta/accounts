Rails.application.routes.draw do
  namespace :v1 do
    resources :legal_person_heads, only: %i[create update]
    resources :legal_person_branchs, only: %i[create update]
    resources :natural_person_heads, only: %i[create update]
    resources :natural_person_branchs, only: %i[create update]
    resources :transfers, only: %i[create index destroy]
    post :contributions, to: 'contributions#fetch_api'
  end
end
