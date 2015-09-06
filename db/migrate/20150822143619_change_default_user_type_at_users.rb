class ChangeDefaultUserTypeAtUsers < ActiveRecord::Migration
  def up
    change_column :users, :user_type, :string, default: 'member'
  end

  def down
    change_column :users, :user_type, :string, default: 'user'
  end
end
