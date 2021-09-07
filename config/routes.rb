Rails.application.routes.draw do
  root "api#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :groups do 
    resources :links
  end
  resources :uploads, only: [:index, :new, :create, :destroy]
  resources :api
end
