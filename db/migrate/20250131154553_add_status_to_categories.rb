class AddStatusToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :status, :integer
  end
end
