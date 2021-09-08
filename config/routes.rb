Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "welcome/index"
  get "indicators" => 'welcome#indicators', as: :indicators
  get "indicator/:indicator" => 'welcome#indicator', as: :indicator
  root to: "welcome#index"

  namespace :api do
    namespace :v1 do
      get "indicator/:indicator" => 'mindicadors#indicator', as: :api_indicator
    end
  end
end
