class Account < ActiveRecord::Base
  extend Enumerize

  enumerize :gender, in: [:male, :female], predicates: true

  belongs_to :user
  has_one :avatar, as: :imageable, class_name: 'Picture', dependent: :destroy
  has_one :emergency_contact, dependent: :destroy

  accepts_nested_attributes_for :emergency_contact, :avatar

  validates :name, presence: true,
    uniqueness: {
      case_sensitive: false,
    }
  validates_presence_of :last_name,
                        :birthday,
                        :gender,
                        :phone,
                        :avatar,
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
