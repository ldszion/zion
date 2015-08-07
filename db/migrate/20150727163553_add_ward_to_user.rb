class AddWardToUser < ActiveRecord::Migration
  def change
    add_reference :users, :ward, index: true, foreign_key: true
  end
end
