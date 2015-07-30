class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :integer, default: 0
  end
end
