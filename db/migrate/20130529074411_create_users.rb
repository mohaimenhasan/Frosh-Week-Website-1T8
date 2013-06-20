class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :discipline
      t.string :email
      t.string :gender
      t.string :shirt_size
      t.integer :group
      t.string :phone
      t.string :residence
      t.integer :package_id
      t.boolean :bursary_requested
      t.boolean :bursary_chosen
      t.string :confirmation_token
      t.boolean :verified
      t.string :emergency_name
      t.string :emergency_phone
      t.string :emergency_relationship
      t.string :emergency_email
      t.string :restrictions_dietary
      t.string :restrictions_accessibility
      t.string :restrictions_misc

      t.timestamps
    end
  end
end
