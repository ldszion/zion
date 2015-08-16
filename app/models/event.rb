# Event class
class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :enrollments
  validates :name, :start_datetime,
    :end_datetime, :description, presence: true

  scope :publicly, -> { where(private: false) }

  # Diz se um evento eh gratuito
  def free?
    !paid?
  end

  # Diz se um evento eh pago
  def paid?
    price = price || 0.0
    price > 0.0
  end

  # Diz se um evento eh publico
  def public?
    !private?
  end

  # Returns the event's start date in string
  def start_date
    start_datetime.strftime('%d/%m/%Y')
  end

  # Returns the event's start time in string
  def start_time
    start_datetime.strftime('%H:%M')
  end

  # Returns the event's end date in string
  def end_date
    end_datetime.strftime('%d/%m/%Y')
  end

  # Returns the event's end time in string
  def end_time
    end_datetime.strftime('%H:%M')
  end
end
