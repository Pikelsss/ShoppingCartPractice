class ProductsController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_product, only: %i[show edit update destroy buy_now]

  def index
    @products = Product.all
  end

  def show
    @cart = current_user.cart || current_user.create_cart(secret_id: generate_secret_id)

    @cart_items = @cart.cart_items.includes(:product) 
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      @product.images.attach(params[:product][:images]) if params[:product][:images]
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      @product.images.attach(params[:product][:images]) if params[:product][:images]
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully deleted.'
  end

  def buy_now
    cart = current_user.cart || current_user.create_cart(secret_id: generate_secret_id)

    cart_item = cart.cart_items.find_or_initialize_by(product: @product)

    cart_item.quantity += 1
    cart_item.save

    redirect_to cart_path(cart), notice: "#{@product.name} has been added to your cart."
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    redirect_to products_path, alert: 'Product not found' unless @product
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_quantity, :category_id, images: [])
  end

  def generate_secret_id
    SecureRandom.hex(10) 
  end
end
