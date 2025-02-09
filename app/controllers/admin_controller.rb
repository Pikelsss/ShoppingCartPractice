class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @products = Product.all
    @categories = Category.all
    @users = User.all
  end

  def show
    @admin = current_admin
  end
end
