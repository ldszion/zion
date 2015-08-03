class EmergencyContact < ActiveRecord::Base
  extend Enumerize
  belongs_to :account

  enumerize :kinship, in: [:father, :mother, :sibling, :spouse, :other], predicates: true

  validates_presence_of :name, :phone, :kinship
  validates_presence_of :account, on: :save
end
