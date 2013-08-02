class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email
      t.text :authorized_routes

      t.timestamps
    end
  end
end
