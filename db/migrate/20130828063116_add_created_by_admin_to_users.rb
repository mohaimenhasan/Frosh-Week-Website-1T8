class AddCreatedByAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :created_by_admin, :string
  end
end
