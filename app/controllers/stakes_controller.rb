class StakesController < ApplicationController
  before_action :set_stake, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user,
                :must_have_person_if_logged_in,
                :must_be_active,
                :check_authorization

  # GET /stakes
  # GET /stakes.json
  def index
    @stakes = Stake.includes(:wards).order(:name)
  end

  # GET /stakes/1
  # GET /stakes/1.json
  def show
  end

  # GET /stakes/new
  def new
    @stake = Stake.new
  end

  # GET /stakes/1/edit
  def edit
  end

  # POST /stakes
  # POST /stakes.json
  def create
    @stake = Stake.new(stake_params)

    respond_to do |format|
      if @stake.save
        format.html { redirect_to @stake, notice: 'Estaca criada com sucesso.' }
        format.json { render :show, status: :created, location: @stake }
      else
        format.html { render :new }
        format.json { render json: @stake.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stakes/1
  # PATCH/PUT /stakes/1.json
  def update
    respond_to do |format|
      if @stake.update(stake_params)
        format.html { redirect_to @stake, notice: 'Estaca atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @stake }
      else
        format.html { render :edit }
        format.json { render json: @stake.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stakes/1
  # DELETE /stakes/1.json
  def destroy
    @stake.destroy
    respond_to do |format|
      format.html { redirect_to stakes_url, notice: 'Estaca removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stake
    @stake = Stake.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def stake_params
    params.require(:stake).permit(:name, :region_id)
  end

  # Verifica se usuario logado tem permissao para acessar a controller
  def check_authorization
    permitted = [:admin]
    fail User::NotAuthorized unless permitted.include? current_user.profile.to_sym
  end
end
