class EventsController < ApplicationController
  before_action :authenticate_user, :must_have_person_if_logged_in, :must_be_active

  def index
    @events = Event.all.order(:name)
  end

  def show
  end

  def enroll
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])

    begin
      event.users << user
      event.save!
      user.save!
      flash[:notice] = "Inscrição realizada com sucesso!"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Usuário ou Evento não encontrados"
    rescue ActiveRecord::RecordNotUnique
      flash[:error] = "Usuário já inscrito no evento!"
    rescue
      flash[:error] = "Erro na inscrição. Contate um administrador!"
    ensure
      redirect_to current_user
    end
  end
end
