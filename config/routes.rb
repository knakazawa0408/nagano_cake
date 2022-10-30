Rails.application.routes.draw do
  root to: "public/homes#top"
  get "/homes/about" => "homes#about", as: "about"

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :public do
    get '/about' => 'homes#about'
    get "customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    post "orders/confirm" => "orders#confirm", as: "confirm"
    get "orders/complete" => "orders#complete", as: "complete"
    resources :customers, only: [:show, :edit, :update]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
    resources :orders, only:[:new, :create, :index, :show]
  end
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
