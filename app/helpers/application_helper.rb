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

  # Returns string 'error' for css class if the record has the error param
  # included to its errors. This method is used for css styling on errors.
  def error_class(record, error)
    if record.errors.any? and record.errors.include? error
      'error'
    end
  end
end
