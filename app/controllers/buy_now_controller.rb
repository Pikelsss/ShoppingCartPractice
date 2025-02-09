class BuyNowController < ApplicationController
  before_action :set_product
  before_action :set_cart

  def show
  end

  def create
    cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    cart_item.quantity += 1
    cart_item.save

    redirect_to buy_now_success_product_path(@product)
  end

  def success
  end

  private

  def set_product
    Rails.logger.debug("Incoming params: #{params.inspect}")
    @product = Product.find(params[:product_id])
  end

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
