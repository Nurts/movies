Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/cities/", to: "requests#cities"
      get "/cities/:id", to: "requests#cinemas"
      get "/cities/:id/movies", to: "requests#movies"
      get "/cities/:id/sessions", to: "requests#sessions"
      get "/cities/:id/movies/:movie_id/sessions", to: "requests#movie_sessions"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
