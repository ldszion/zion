class CreateStakes < ActiveRecord::Migration
  def change
    create_table :stakes do |t|
      t.string :name
      t.belongs_to :region, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
