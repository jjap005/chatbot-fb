Rails.application.routes.draw do

  scope '(:locale)', locale: /#{I18n.available_locales.join('en|es')}/ do
    devise_for :users,
      path: "u",
      path_names: {
        sign_in: 'login', sign_out: 'logout',
        password: 'password', confirmation: 'verification',
        sign_up: 'register', edit: 'profile'
      }

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
end
