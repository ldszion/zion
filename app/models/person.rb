class Person < ActiveRecord::Base
  belongs_to :ward
  has_many :phones, as: :phoneable
  has_one :avatar, as: :imageable

  MALE   = 1
  FEMALE = 2

  # Returns the person's full name
  def full_name
    self.name + " " + self.last_name
  end

  # Returns the current person's age
  def age
    now = Time.now.utc.to_date
    now.year - self.birthday.year - (
      (now.month > self.birthday.month ||
        (now.month == self.birthday.month &&
          now.day >= self.birthday.day)) ? 0 : 1
    )
  end
end
