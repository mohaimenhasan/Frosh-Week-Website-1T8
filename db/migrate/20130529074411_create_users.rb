class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :discipline
      t.string :email
      t.string :gender
      t.string :shirt_size
      t.string :phone
      t.string :residence
      t.integer :package_id
      t.boolean :bursary_requested
      t.boolean :bursary_chosen
      t.boolean :bursary_paid
      t.integer :bursary_scholarship_amount
      t.text :bursary_engineering_motivation
      t.text :bursary_financial_reasoning
      t.text :bursary_after_graduation
      t.string :confirmation_token
      t.boolean :verified
      t.string :emergency_name
      t.string :emergency_phone
      t.string :emergency_relationship
      t.string :emergency_email
      t.text :restrictions_dietary
      t.text :restrictions_accessibility
      t.text :restrictions_misc
      t.belongs_to :group

      t.timestamps
    end
  end
end
