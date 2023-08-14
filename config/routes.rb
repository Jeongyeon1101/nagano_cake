Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/information/edit' => 'customers#edit', as: 'my_page_edit'
    patch 'customers/information' => 'customers#update', as: 'my_page_update'
    patch 'customers/withdraw'
    get 'customers/confirm'
    get 'orders/complete'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index]
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
