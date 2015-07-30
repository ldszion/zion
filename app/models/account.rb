class Account < ActiveRecord::Base

  enum gender: [:male, :female]

  has_one :user
  has_many :phones, as: :phoneable
  has_one :avatar, as: :imageable, class_name: 'Picture'
  has_one :emergency_contact

  accepts_nested_attributes_for :phones, :avatar, :emergency_contact

  validates :name, presence: true,
    uniqueness: {
      case_sensitive: false,
    }
  validates_presence_of :last_name,
                        :birthday,
                        :gender,
                        :address,
                        :phones,
                        :emergency_contact


  # Returns the person's full name
  def full_name
    name + ' ' + last_name
  end

  # Returns the current person's age
  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (
      (now.month > birthday.month ||
        (now.month == birthday.month &&
          now.day >= birthday.day)) ? 0 : 1
    )
  end
end
