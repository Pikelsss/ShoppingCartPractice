class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :stock_quantity
      t.references :category, null: false, foreign_key: true  # This line creates the category_id field

      t.timestamps
    end
  end
end
