class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :last_name
      t.string :nickname
      t.string :address
      t.date :birthday
      t.integer :gender
      t.references :ward, index: true, foreign_key: true
      t.boolean :member

      t.timestamps null: false
    end
  end
end
