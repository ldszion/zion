class Event < ActiveRecord::Base
  # Retorna a data de início do evento em string
  def start_date
    self.start_datetime.strftime("%d/%m/%Y")
  end

  # Retorna a hora de início do evento em string
  def start_time
    self.start_datetime.strftime("%H:%M")
  end

  # Retorna a data de término do evento em string
  def end_date
    self.end_datetime.strftime("%d/%m/%Y")
  end

  # Retorna a hora de término do evento em string
  def end_time
    self.end_datetime.strftime("%H:%M")
  end
end
