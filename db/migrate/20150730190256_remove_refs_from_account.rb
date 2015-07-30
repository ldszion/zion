class RemoveRefsFromAccount < ActiveRecord::Migration
  def change
  	remove_reference  :accounts, :ward, index: true, foreign_key: true
  	remove_reference :users, :profile, index: true, foreign_key: true
  	rename_column :users, :person_id, :account_id
  	rename_column :emergency_contacts, :person_id, :account_id
  	drop_table :profiles
  end
end
