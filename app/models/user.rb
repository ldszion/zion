class User < ActiveRecord::Base
  has_secure_password
  
  enum profile: [:user, :ward_leader, :stake_leader, :region_leader, :admin]

  belongs_to :account
  belongs_to :ward

  validates :email,
    presence: { presence: true },
    uniqueness: { case_sensitive: false },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates_presence_of :ward
  validates_length_of :password, in: 6..16, on: :create

  def register_to event
    "registrando em #{event.name}"
  end

  # Appends the array params to user's errors
  def append_errors array
    array.each do |key, value|
      self.errors[key] = value
    end
  end
end
