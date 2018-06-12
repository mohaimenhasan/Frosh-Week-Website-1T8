class RemoveDetailsFromPackages < ActiveRecord::Migration
  def change
      remove_column :packages, :description
  end
end
