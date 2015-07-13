# Event class
class Event < ActiveRecord::Base
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
