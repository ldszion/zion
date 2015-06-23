module ApplicationHelper
  # Verifica se o controller atual é igual ao passado como parâmetro para
  # dizer se o item do menu está ativo ou não.
  # {param} controller
  def active_item controller
    'active' if controller == controller_name
  end
end
