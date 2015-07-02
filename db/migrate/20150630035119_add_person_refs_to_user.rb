class AddPersonRefsToUser < ActiveRecord::Migration
  def change
    add_reference :users, :person, index: true, foreign_key: true
  end
end
