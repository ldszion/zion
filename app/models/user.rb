class User < ActiveRecord::Base
  has_secure_password
  belongs_to :profile

  validates :email,
    presence: {presence: true, message: "Email obrigatório"},
    uniqueness: {uniqueness: true, message: "Email já existe"}

  def register_to event
    "registrando em #{event.name}"
  end

  # Returns true if user's profile is admin.
  def is_admin?
    self.profile.key == Profile::ADMIN
  end

  # Returns true if user's profile is common user.
  def is_user?
    self.profile.key == Profile::USER
  end

  # Returns true if user's profile is ward leader.
  def is_ward_leader?
    self.profile.key == Profile::WARD_LEADER
  end

  # Returns true if user's profile is stake leader.
  def is_stake_leader?
    self.profile.key == Profile::STAKE_LEADER
  end

  # Returns true if user's profile is region leader.
  def is_region_leader?
    self.profile.key == Profile::REGION_LEADER
  end
end
