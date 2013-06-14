class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :count
      t.integer :max
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
