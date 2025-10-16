Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  resources :customers, only: [:show, :edit, :update] do
  end

  root to: "public/homes#top"
  get "about", to: "public/homes#about", as: "homes_about"
  scope module: :public do
    resources :items, only: [:index, :show]
  end
end
