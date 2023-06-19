Rails.application.routes.draw do
  resources :sales do
    collection do
      post :import
    end
  end
  resources :companies
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'companies#show', id: '1'
end
