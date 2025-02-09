class CheckoutController < ApplicationController
  before_action :authenticate_user! 

  def index
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:product) if @cart.present?
  end

  def complete
    @cart = current_user.cart

    if @cart.present? && @cart.cart_items.any?

      @cart.cart_items.destroy_all 
      redirect_to root_path, notice: "Purchase completed successfully."
    else
      redirect_to checkout_path, alert: "Your cart is empty. Cannot complete the purchase."
    end
  end
end
