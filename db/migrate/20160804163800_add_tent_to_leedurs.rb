class AddTentToLeedurs < ActiveRecord::Migration
  def change
    add_column :leedurs, :tent, :boolean, default: false
  end
end
