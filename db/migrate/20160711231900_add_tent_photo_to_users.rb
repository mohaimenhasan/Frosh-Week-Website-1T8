class AddTentPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo_consent, :boolean, default: false
    add_column :users, :tent, :boolean, default: false
  end
end
