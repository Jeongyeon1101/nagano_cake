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
    resources :customers, only: [:index, :show, :edit]
    resources :items, only: [:new, :index, :show, :edit]
    resources :genres, only: [:index, :edit]
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get '/customers/information/edit' => 'customers#edit', as: 'my_page_edit'
    get 'orders/complete', as: 'order_complete_path'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index]
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end