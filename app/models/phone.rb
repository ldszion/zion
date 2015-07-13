class Phone < ActiveRecord::Base
  # attr_accessible :phoneable_id, :phoneable_type
  belongs_to :phoneable, polymorphic: true

  validates_presence_of :number
end
