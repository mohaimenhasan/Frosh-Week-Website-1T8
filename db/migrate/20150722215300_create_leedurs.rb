class CreateLeedurs < ActiveRecord::Migration
  def change
    create_table :leedurs do |t|
      t.string :first_name
      t.string :last_name
      t.string :year
      t.string :discipline
      t.string :email
      t.string :gender
      t.string :phone
      t.string :confirmation_token
      t.boolean :verified
      t.string :emergency_name
      t.string :emergency_phone
      t.string :emergency_relationship
      t.string :emergency_email
      t.text :restrictions_dietary
      t.text :restrictions_misc
      t.string :charge_id
      t.string :ticket_number
      t.belongs_to :hhf_packages

      t.timestamps
    end

    add_index :leedurs, :email, unique: true
  end
end