class AddPrivateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :private, :integer, null: false, default: 0
  end
end
