class AddDetailsToLeedurs < ActiveRecord::Migration
  def change
  	add_column :leedurs, :created_by_admin, :string
    add_column :leedurs, :checked_in, :boolean, default: false
  end
end
