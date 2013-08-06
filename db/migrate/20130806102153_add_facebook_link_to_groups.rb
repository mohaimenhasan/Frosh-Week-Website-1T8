class AddFacebookLinkToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :facebook_link, :string
  end
end
