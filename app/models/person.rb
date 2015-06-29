class Person < ActiveRecord::Base
  belongs_to :ward
  has_many :phones, as: :phoneable
  has_one :avatar, as: :imageable

  MALE   = 1
  FEMALE = 2
end
