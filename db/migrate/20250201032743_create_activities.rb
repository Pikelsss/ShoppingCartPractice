class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :description
      t.references :admin, foreign_key: true
      t.timestamps
    end
  end
end
