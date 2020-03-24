Rails.application.routes.draw do
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

  resources :years, path: "", only: [:show], constraints: { id: /\d{4}/ } do
    resources :weeks, only: [:show], constraints: { id: /\d{1,2}/ }
    resources :months, path: "", only: [:show], constraints: { id: /\d{2}/ } do
      resources :days, path: "", only: [:show], constraints: { id: /\d{2}/ }
    end
  end

  root to: "time_ranges#show", name: "day"
end
