class User < ActiveRecord::Base
  has_secure_password
  extend Enumerize

  enumerize :profile, in: [:user, :ward_leader, 
    :bishopric, :stake_leader, :region_leader, :admin], default: :user, predicates: true

  has_one :account, dependent: :destroy
  belongs_to :ward
  has_and_belongs_to_many :events, join_table: :enrollments

  validates :email,
    presence: { presence: true },
    uniqueness: { case_sensitive: false },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates_presence_of :ward, :profile
  validates_length_of :password, in: 6..16, on: [:create, :update],
    if: :not_blank_or_new

  def not_blank_or_new
    !password.blank? || new_record?
  end

  def register_to event
    "registrando em #{event.name}"
  end

  # Appends the array params to user's errors
  def append_errors array
    array.each do |key, value|
      self.errors[key] = value
    end
  end

  def leader?
    self.profile != :user
  end
end
