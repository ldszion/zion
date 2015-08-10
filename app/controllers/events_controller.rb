class EventsController < ApplicationController
  before_action :authenticate_user, :must_have_person_if_logged_in, :must_be_active

  def index
    @events = Event.all.order(:name)
  end

  def show
    @event = Event.find(params[:id])
  end

  def enroll
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])

    if(Time.now < event.end_datetime)
      begin
        event.users << user
        event.save!
        user.save!
        notice = "Inscrição realizada com sucesso!"
      rescue ActiveRecord::RecordNotFound
        notice = "Usuário ou Evento não encontrados"
      rescue ActiveRecord::RecordNotUnique
        notice = "Usuário já inscrito no evento!"
      rescue
        notice = "Erro na inscrição. Contate um administrador!"
      end
    else
      notice = "Inscrições não são mais permitidas neste evento!"
    end
    redirect_to :back, notice: notice
  end
end
