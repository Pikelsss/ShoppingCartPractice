# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  # Override the after_sign_in_path_for method to redirect to products index
  protected

  def after_sign_in_path_for(resource)
    products_path # Redirect to the products index page
  end
end
