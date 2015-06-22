class RemoveDetailsFromPackages < ActiveRecord::Migration
  def change
      remove_column :packages, :description, :text
      remove_column :packages, :max, :int
  end
end