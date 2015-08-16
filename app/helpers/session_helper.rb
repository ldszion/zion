module SessionHelper
  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remove user from session
  def logout
    session.delete :user_id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?
    !current_user.nil?
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Armazena a ultima localizacao do usuario convidado
  def store_location
    if request.get?
      store_event_location if event_enroll_path?
      session[:forwarding_url] = request.url unless event_enroll_path?
    end
  end

  # Retorna true se url for a pagina de registro de um evento
  def event_enroll_path?
    controller_name == 'events' && action_name == 'enroll'
  end

  def store_event_location
    session[:last_event_location] = request.url
  end

  # Redireciona o usuario de volta para url ou para o padrao
  def redirect_back_or(default)
    back_url = session[:last_event_location] || session[:forwarding_url]
    # abort back_url
    redirect_to(back_url || default)
    session.delete(:forwarding_url)
    session.delete(:last_event_location)
  end
end
