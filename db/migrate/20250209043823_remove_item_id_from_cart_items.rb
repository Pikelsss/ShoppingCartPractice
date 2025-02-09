class RemoveItemIdFromCartItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :cart_items, :item_id, :integer
  end
end
