class ChangeEnumFields < ActiveRecord::Migration
  def change
    change_column :accounts, :gender, :string
    change_column :users, :profile, :string
    change_column :emergency_contacts, :kinship, :string
  end
end
