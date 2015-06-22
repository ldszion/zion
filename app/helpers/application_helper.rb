module ApplicationHelper
  def active_item controller
    'active' if controller == controller_name
  end
end
