class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :symbol
      t.string :code
      
      t.timestamps
    end
  end
end
