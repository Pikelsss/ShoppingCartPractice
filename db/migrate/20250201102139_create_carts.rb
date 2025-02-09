# db/migrate/xxxx_create_carts.rb
class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.string :secret_id, null: false
      t.timestamps
    end
    add_index :carts, :secret_id, unique: true
  end
end
