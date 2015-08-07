module AccountHelper
  def brazilian_date date
    date.strftime('%d/%m/%Y')
  end
end
