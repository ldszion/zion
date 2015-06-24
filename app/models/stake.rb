class Stake < ActiveRecord::Base
  belongs_to :region
  has_many :wards
end
