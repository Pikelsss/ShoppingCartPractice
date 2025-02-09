class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true  # Ensure this is not null
      t.integer :quantity, null: false, default: 1  # Ensure this is not null

      t.timestamps
    end
  end
end