class RemoveEmailUniqueFromLeedurs < ActiveRecord::Migration
  def change
    remove_column :leedurs, :email
    add_column :leedurs, :email, :string

  end
end
