class ApplicationController < ActionController::Base
  before_action :set_current_cart

  protected

  def check_admin_priv
    redirect_to root_path unless current_admin
  end

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id]) if session[:cart_id]
    @current_cart ||= Cart.create 
  end

  private

  def set_current_cart
    if session[:current_cart_id]
      @current_cart = Cart.find_by(secret_id: session[:current_cart_id])
    else
      @current_cart = Cart.create(secret_id: SecureRandom.uuid)
      session[:current_cart_id] = @current_cart.secret_id
    end
  end
end
