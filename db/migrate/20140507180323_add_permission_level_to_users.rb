class AddPermissionLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permission_levels, :string
  end
end
