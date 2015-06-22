class CreatePackageItems < ActiveRecord::Migration
  def change
      create_table :package_items do |t|
      t.string :key
      t.string :name
      t.text :description
      t.integer :price
      t.integer :count
      t.integer :max
      t.integer :left
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
