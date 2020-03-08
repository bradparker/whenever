Rails.application.routes.draw do
  resources :events, except: [:index]

  resources :years, path: "", only: [:show], constraints: { id: /\d{4}/ } do
    resources :weeks, only: [:show], constraints: { id: /\d{1,2}/ }
    resources :months, path: "", only: [:show], constraints: { id: /\d{2}/ } do
      resources :days, path: "", only: [:show], constraints: { id: /\d{2}/ }
    end
  end

  get "/", to: redirect {
    now = Time.now
    year = Year.new(now.year)
    month = Month.new(now.year, now.month)
    day = Day.new(now.year, now.month, now.day)

    "/#{year.to_param}/#{month.to_param}/#{day.to_param}"
  }
end
