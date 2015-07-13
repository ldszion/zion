module UsersHelper
  def has_person
    !current_user.person.nil?
  end
end
