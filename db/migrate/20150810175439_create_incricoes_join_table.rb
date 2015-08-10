class CreateIncricoesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :events, table_name: :enrollments do |t|
      t.index [:user_id, :event_id], unique: true
      t.index [:event_id, :user_id], unique: true
    end
  end
end
