class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :verified
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :shirt_size
      t.string :residence
      t.string :discipline
      t.integer :group
      t.string :emergency_name
      t.string :emergency_relationship
      t.string :emergency_phone
      t.string :restrictions_dietary
      t.string :restrictions_misc

      t.timestamps
    end
  end
end
