class AddBusToLeedurs < ActiveRecord::Migration
  def change
    add_column :leedurs, :bus, :boolean, default: false
  end
end
