Rails.application.routes.draw do
  resources :endpoints#, except: :show

  match "/:url" => "endpoints#show", via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
