class AddCartStatusToCarts < ActiveRecord::Migration[6.0]  # Adjust the version number as needed
  def change
    add_column :carts, :cart_status, :integer, default: 0  # Default to pending
  end
end