class CreateWards < ActiveRecord::Migration
  def change
    create_table :wards do |t|
      t.string :name
      t.belongs_to :stake, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
