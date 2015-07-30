class EmergencyContact < ActiveRecord::Base
  belongs_to :account

  enum kinship: [:father, :mother, :sibling, :spouse, :other]

  validates_presence_of :name, :phone, :kinship
  validates_presence_of :account, on: :save
end
