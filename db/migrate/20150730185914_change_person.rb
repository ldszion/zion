class ChangePerson < ActiveRecord::Migration
  def change
  	rename_table :people, :accounts
  end
end
