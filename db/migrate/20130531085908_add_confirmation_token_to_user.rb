class AddConfirmationTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_token, :string
  end
end
