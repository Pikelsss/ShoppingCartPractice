Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_for :admins

  # Admin Dashboard
  get 'admin/dashboard', to: 'admin#index', as: 'admin_dashboard'

  # Categories and Products
  resources :categories do
    resources :products, only: [:index, :show]
  end

  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      post 'buy_now'  # "Buy Now"
    end
  end

  # Cart (Single cart per user)
  resource :cart, only: [:show, :destroy] do
    post 'add_item', to: 'carts#add_item'  # Add item to cart
  end

  # Update quantity
  patch 'cart/update_quantity/:id', to: 'carts#update_quantity', as: 'update_cart_quantity'

  # Remove items from cart
  delete 'cart/remove_item/:id', to: 'carts#remove_item', as: 'remove_item_cart'

  # Empty the cart
  delete '/cart', to: 'carts#destroy', as: 'empty_cart'

  # Checkout routes
  get 'checkout', to: 'checkout#index', as: 'checkout'  # Checkout page
  post 'checkout/complete', to: 'checkout#complete', as: 'complete_checkout'  # Purchase completion

  # Buy Now success page
  get 'buy_now/success', to: 'buy_now#success', as: 'buy_now_success'

  # Root Path
  root 'products#index'
end
