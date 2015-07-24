class EmergencyContact < ActiveRecord::Base
  belongs_to :person

  validates_presence_of :name, :phone, :kinship
  validates_presence_of :person, on: :save

  # Returns the Emergency Contact's kinship
  def kinship_name
    Person::KINSHIP[kinship - 1][0]
  end
end
