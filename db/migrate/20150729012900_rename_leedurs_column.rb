class RenameLeedursColumn < ActiveRecord::Migration
  def change
  	rename_column :leedurs, :hhf_packages_id, :hhf_package_id
  end
end
