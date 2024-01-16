Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'openai', to: 'openai#index'
  # Defines the root path route ("/")
  root "article#index"
end
