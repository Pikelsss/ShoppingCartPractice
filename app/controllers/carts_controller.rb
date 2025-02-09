class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_item, :update_quantity, :remove_item, :destroy]

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add_item
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += 1
    cart_item.save!

    redirect_to cart_path, notice: "#{product.name} has been added to your cart."
  end

  def update_quantity
    cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity > 0
      cart_item.update(quantity: new_quantity)
      redirect_to cart_path, notice: "Quantity updated."
    else
      cart_item.destroy
      redirect_to cart_path, notice: "#{cart_item.product.name} removed from cart."
    end
  end

  def remove_item
    cart_item = @cart.cart_items.find_by(id: params[:id])

    if cart_item
      cart_item.destroy
      redirect_to cart_path, notice: "#{cart_item.product.name} has been removed from your cart."
    else
      redirect_to cart_path, alert: "Item not found in the cart."
    end
  end

  def destroy
    @cart.cart_items.destroy_all
    redirect_to root_path, notice: "Cart emptied successfully."
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart(secret_id: SecureRandom.hex(10))
  end
end
