class AddNoteToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :note, :text
  end
end
