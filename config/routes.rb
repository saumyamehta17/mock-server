Rails.application.routes.draw do
  resources :endpoints, defaults: { format: :json } #, except: :show,

  match "/:url" => "endpoints#show", via: :all

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
