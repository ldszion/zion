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
    'error' if record.errors.any? && record.errors.include?(error)
  end

  # Retorna a data no formato padrao do Brasil
  def brazilian_date(date)
    return date.strftime('%d/%m/%Y') unless date.nil?
    ''
  end
end
