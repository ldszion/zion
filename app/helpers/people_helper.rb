module PeopleHelper
  def brazilian_date date
    date.strftime('%d/%m/%Y')
  end
end
