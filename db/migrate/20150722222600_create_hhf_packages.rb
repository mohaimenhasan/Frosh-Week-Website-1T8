class CreateHhfPackages < ActiveRecord::Migration
  def change
    create_table :hhf_packages do |t|
      t.string :name
      t.string :key
      t.integer :price
      t.timestamps
    end
  end
end