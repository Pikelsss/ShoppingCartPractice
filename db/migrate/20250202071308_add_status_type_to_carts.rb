class AddStatusTypeToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :status_type, :integer
  end
end
