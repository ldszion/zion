class Profile < ActiveRecord::Base
  has_many :users

  def self.user
    self.find_by_key USER
  end

  ADMIN         = 'admin'
  USER          = 'user'
  WARD_LEADER   = 'ward_leader'
  STAKE_LEADER  = 'stake_leader'
  REGION_LEADER = 'region_leader'
end
