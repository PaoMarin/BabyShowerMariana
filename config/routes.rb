Rails.application.routes.draw do
  resources :scort_guests
  resources :guests do
    get 'cancel_invitation'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'guests#index'
end
