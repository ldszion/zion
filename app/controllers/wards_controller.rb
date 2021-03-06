class WardsController < ApplicationController
  before_action :set_ward, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user,
                :must_have_person_if_logged_in,
                :must_be_active,
                :check_authorization

  # GET /wards
  # GET /wards.json
  def index
    @wards = Ward.includes(:stake).order(:name)
  end

  # GET /wards/1
  # GET /wards/1.json
  def show
  end

  # GET /wards/new
  def new
    @ward = Ward.new
  end

  # GET /wards/1/edit
  def edit
  end

  # POST /wards
  # POST /wards.json
  def create
    @ward = Ward.new(ward_params)

    respond_to do |format|
      if @ward.save
        format.html { redirect_to wards_url, notice: 'Ala criada com sucesso.' }
        format.json { render :show, status: :created, location: @ward }
      else
        format.html { render :new }
        format.json { render json: @ward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wards/1
  # PATCH/PUT /wards/1.json
  def update
    respond_to do |format|
      if @ward.update(ward_params)
        format.html { redirect_to wards_url,
                      notice: 'Ala atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @ward }
      else
        format.html { render :edit }
        format.json { render json: @ward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wards/1
  # DELETE /wards/1.json
  def destroy
    @ward.destroy
    respond_to do |format|
      format.html { redirect_to wards_url, notice: 'Ala removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ward
    @ward = Ward.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ward_params
    params.require(:ward).permit(:name, :stake_id)
  end

  # Verifica se usuario logado tem permissao para acessar a controller
  def check_authorization
    permitted = [:admin]
    raise User::NotAuthorized unless permitted.include? current_user.profile.to_sym
  end
end
