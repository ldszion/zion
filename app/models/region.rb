class Region < ActiveRecord::Base
  has_many :stakes, dependent: :destroy
  has_many :wards, through: :stakes
end
