class Profile < ActiveRecord::Base
  has_many :users

  ADMIN         = 'admin'
  USER          = 'user'
  WARD_LEADER   = 'ward_leader'
  STAKE_LEADER  = 'stake_leader'
  REGION_LEADER = 'region_leader'
end
