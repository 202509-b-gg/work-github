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

  root to: "public/homes#top"
  get "about", to: "public/homes#about", as: "homes_about"

  scope module: :public do
    resources :customers, only: [:show, :edit, :update] 
    # get 'customers/my_page', to: 'customers#show', as: 'my_page'
    get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'unsubscribe_customer'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
  end
end
