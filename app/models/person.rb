class Person < ActiveRecord::Base
  belongs_to :ward
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
                        :ward,
                        :phones,
                        :avatar,
                        :emergency_contact

  MALE   = 1
  FEMALE = 2
  GENDER = [%w(Homem 1), %w(Mulher 2)]

  FATHER  = 1
  MOTHER  = 2
  SIBLING = 3
  SPOUSE  = 4
  OTHER   = 5
  KINSHIP = [%w(Pai 1), %w(Mãe 2), %w(Irmão(ã) 3), %w(Cônjuge 4), %w(Outro 5)]

  # Returns the person's full name
  def full_name
    name + ' ' + last_name
  end

  # Returns the person's stake through his ward
  def stake
    ward.stake
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
