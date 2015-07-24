class CreateHhfPackageItems < ActiveRecord::Migration
  def change
    create_table :hhf_package_items do |t|
      t.string :name
      t.string :key
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