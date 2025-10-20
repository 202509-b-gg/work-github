Rails.application.routes.draw do
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  namespace :public do
    get 'cart_items/index'
  end
  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用リソース
  root to: "public/homes#top"
  get "about", to: "public/homes#about", as: "homes_about"

  scope module: :public do
    get 'customers/my_page', to: 'customers#show', as: 'my_page'
    get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'unsubscribe_customer'
    patch 'customers/withdraw', to: 'customers#withdraw', as: 'withdraw_customer'
    get 'customers/infomation/edit', to: 'customers#edit', as: 'edit_customer_information'
    patch 'customers/infomation', to: 'customers#update', as: 'update_customer_information'

    resources :customers, only: [:show, :edit, :update] 
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
    resources :cart_items, only: [:index, :edit, :create, :update, :destroy] do
      collection do
      delete 'destroy_all'
      end
    end
  end

  # 管理者用リソース
  namespace :admin do
    root to: "homes#top"
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
