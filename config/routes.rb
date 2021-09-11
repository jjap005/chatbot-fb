Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('en|es')}/ do
    devise_for :users, path: 'u',
      path_names: {
        sign_in: 'login', sign_out: 'logout',
        password: 'password', confirmation: 'verification',
        sign_up: 'register', edit: 'profile'
      }

    get 'welcome/index'
    get 'indicators' => 'welcome#indicators', as: :indicators
    get 'indicator/:indicator' => 'welcome#indicator', as: :indicator
    root to: 'welcome#index'

    scope '/customers', controller: 'customers' do
      get '/' => 'customers#index', as: :customers
    end
    namespace :api do
      namespace :v1 do
        get 'indicator/:indicator' => 'mindicadors#indicator', as: :api_indicator
        post 'founds/add' => 'founds#add_found', as: :api_found_add
        post 'founds/search' => 'founds#search_found', as: :api_found_search
        post 'request-paper/add' => 'request_papers#request_paper', as: :api_request_paper
      end
    end
  end
end
