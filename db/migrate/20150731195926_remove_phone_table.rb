class RemovePhoneTable < ActiveRecord::Migration
  def change
    drop_table :phones
    add_column :accounts, :phone, :string
  end
end
