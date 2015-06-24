module ApplicationHelper
  # Verifica se o controller atual é igual ao passado como parâmetro para
  # dizer se o item do menu está ativo ou não.
  # {param} controller
  def active_item controller
    if controller.is_a? String
      controller = controller.split
    end
    controller.each do |c|
      return 'active' if c == controller_name
    end
    ""
  end
end
