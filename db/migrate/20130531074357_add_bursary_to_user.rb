class AddBursaryToUser < ActiveRecord::Migration
  def change
    add_column :users, :bursary, :boolean
  end
end
