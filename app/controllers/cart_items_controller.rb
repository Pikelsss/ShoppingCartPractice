class CartItemsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_cart
  before_action :set_cart_item, only: [:update, :destroy, :increment, :decrement]

  def index
    @cart_items = @cart.cart_items.includes(:product) 
  end

  def create
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    
    @cart_item.item_id = params[:item_id] || Product.find(params[:product_id])&.item_id

    if @cart_item.item_id.nil?
      redirect_to cart_path, alert: 'Failed to add item to cart: Missing item_id.' and return
    end

    @cart_item.quantity += params[:quantity].to_i

    if @cart_item.save
      redirect_to cart_path, notice: 'Item added to cart.'
    else
      redirect_to cart_path, alert: 'Failed to add item to cart.'
    end
  end

  def update
    if @cart_item.update(quantity: params[:quantity].to_i)
      redirect_to cart_path, notice: 'Cart item updated.'
    else
      redirect_to cart_path, alert: 'Failed to update cart item.'
    end
  end

  def destroy
    if @cart_item.destroy
      redirect_to cart_path, notice: 'Item removed from cart.'
    else
      redirect_to cart_path, alert: 'Failed to remove item from cart.'
    end
  end

  def increment
    @cart_item.increment!(:quantity)
    redirect_to cart_path, notice: 'Quantity updated successfully.'
  end

  def decrement
    if @cart_item.quantity > 1
      @cart_item.decrement!(:quantity)
      redirect_to cart_path, notice: 'Quantity updated successfully.'
    else
      destroy 
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart(secret_id: SecureRandom.uuid)
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end
end
