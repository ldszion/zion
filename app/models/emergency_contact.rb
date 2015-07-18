class EmergencyContact < ActiveRecord::Base
  belongs_to :person

  validates_presence_of :name, :phone, :kinship
  validates_presence_of :person, on: :save
end
