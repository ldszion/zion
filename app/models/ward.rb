class Ward < ActiveRecord::Base
  belongs_to :stake
  has_many :users, dependent: :destroy
end
