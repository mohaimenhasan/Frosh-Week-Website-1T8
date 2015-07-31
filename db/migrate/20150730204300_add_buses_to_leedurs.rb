class AddBusesToLeedurs < ActiveRecord::Migration
  def change
    remove_column :leedurs, :bus
    add_column :leedurs, :leedurbus, :boolean, default: false
    add_column :leedurs, :fweekbus, :boolean, default: false

  end
end
