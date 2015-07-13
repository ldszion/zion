class User < ActiveRecord::Base
  has_secure_password
  belongs_to :profile
  belongs_to :person

  validates :email,
    presence: { presence: true, message: "obrigatório" },
    uniqueness: { uniqueness: true, message: "já existe" },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates_presence_of :profile

  def register_to event
    "registrando em #{event.name}"
  end

  # Appends the array params to user's errors
  def append_errors array
    array.each do |key, value|
      self.errors[key] = value
    end
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
