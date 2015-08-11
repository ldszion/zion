class RemoveAccountRefsFromUser < ActiveRecord::Migration
  def change
    remove_reference :users, :account, index: true, foreign_key: true
  end
end
