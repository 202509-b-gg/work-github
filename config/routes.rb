Rails.application.routes.draw do
  devise_for :users

  root to: "public/homes#top"
  get "about", to: "public/homes#about", as: "homes_about"
  scope module: :public do
    resources :items, only: [:index, :show]
  end
end
