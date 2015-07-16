class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|
      t.string :name
      t.string :phone
      t.integer :kinship
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
