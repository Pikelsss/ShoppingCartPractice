class AddSeoTitleToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :seo_title, :string
    add_column :categories, :seo_description, :text
  end
end
