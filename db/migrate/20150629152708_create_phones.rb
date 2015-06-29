class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.integer :provider
      t.references :phoneable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
