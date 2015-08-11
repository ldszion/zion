class EventsController < ApplicationController
  before_action :authenticate_user, :must_have_person_if_logged_in, :must_be_active

  def index
    @events = Event.all.order(:name)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    time = Time.now
    @event = Event.new(start_datetime: time,
      end_datetime: time)
  end

  def create
    @event = Event.new(event_params)
    convert_dates
    if(@event.save)
      notice = "Evento criado com sucesso"
      redirect_to current_user, notice: notice
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    notice = nil
    alert = nil
    if(@event.destroy!)
      notice = "Evento excluído com sucesso!"
    else
      alert = "Evento não pôde ser excluído, contate o administrador!"
    end
    redirect_to :back, notice: notice, alert: alert
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    convert_dates
    if(@event.save)
      notice = "Evento alterado com sucesso"
      redirect_to current_user, notice: notice
    else
      render :edit
    end
  end

  def enroll
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])
    notice = nil
    alert = nil
    if(Time.now < event.end_datetime)
      begin
        event.users << user
        event.save!
        user.save!
        notice = "Inscrição realizada com sucesso!"
      rescue ActiveRecord::RecordNotFound
        alert = "Usuário ou Evento não encontrados"
      rescue ActiveRecord::RecordNotUnique
        alert = "Usuário já inscrito no evento!"
      rescue
        alert = "Erro na inscrição. Contate um administrador!"
      end
    else
      alert = "Inscrições não são mais permitidas neste evento!"
    end
    redirect_to :back, notice: notice, alert: alert
  end

  def leave
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])
    notice = nil
    alert = nil
    if(Time.now < event.end_datetime)
      begin
        event.users.destroy(user)
        event.save!
        notice = "Cancelamento realizado com sucesso!"
      rescue ActiveRecord::RecordNotFound
        alert = "Usuário ou Evento não encontrados"
      rescue
        alert = "Erro no cancelamento. Contate um administrador!"
      end
    else
      alert = "Cancelar inscrição não é mais permitido neste evento!"
    end
    redirect_to :back, notice: notice, alert: alert
  end

  def convert_dates
    start_datetime = params[:event][:start_date] + ' ' + params[:event][:start_time]
    @event.start_datetime = start_datetime.to_datetime
    end_datetime = params[:event][:end_date] + ' ' + params[:event][:end_time]
    @event.end_datetime = end_datetime.to_datetime
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end
end
