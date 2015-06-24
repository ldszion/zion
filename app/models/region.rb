class Region < ActiveRecord::Base
  has_many :stakes
  has_many :wards, through: :stakes
end
