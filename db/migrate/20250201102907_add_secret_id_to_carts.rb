class AddSecretIdToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :secret_id, :string, null: false
    add_index :carts, :secret_id, unique: true
  end
end
