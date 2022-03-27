Rails.application.routes.draw do
  root to: "home#index"

  get "/api/v1/auth" , to: "api/v1/auth/registrations#sign_up_params"

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations"
      }
      resources :articles
    end
  end
end
