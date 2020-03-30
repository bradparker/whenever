Rails.application.routes.draw do
  get "sign_in", to: "sessions#new"
  get "sign_up", to: "registrations#new"

  resources :registrations, only: [:new]
  constraints format: :json do
    resources :registrations, only: [:create, :show], param: :username
  end

  resources :sesssions, only: [:new]
  constraints format: :json do
    resources :sessions, only: [:create] do
      member do
        post "verify"
      end
    end
  end

  resources :years, path: "", only: [:show], constraints: { id: /\d{4}/ } do
    resources :weeks, only: [:show], constraints: { id: /\d{1,2}/ }
    resources :months, path: "", only: [:show], constraints: { id: /\d{2}/ } do
      resources :days, path: "", only: [:show], constraints: { id: /\d{2}/ }
    end
  end

  resources(
    :time_ranges,
    path: "",
    param: :name,
    only: [:show],
    constraints: {
      time_range_name: /year|month|week|day/,
    },
  ) do
    resources :events, except: [:index]
  end

  root to: "time_ranges#show", name: "day"
end
