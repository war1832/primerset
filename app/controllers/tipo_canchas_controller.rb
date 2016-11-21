class TipoCanchasController < ApplicationController
  before_action :set_tipo_cancha, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :verify_is_admin

  # GET /tipo_canchas
  # GET /tipo_canchas.json
  def index
    @tipo_canchas = TipoCancha.all
  end

  # GET /tipo_canchas/1
  # GET /tipo_canchas/1.json
  def show
  end

  # GET /tipo_canchas/new
  def new
    @tipo_cancha = TipoCancha.new
  end

  # GET /tipo_canchas/1/edit
  def edit
  end

  # POST /tipo_canchas
  # POST /tipo_canchas.json
  def create
    @tipo_cancha = TipoCancha.new(tipo_cancha_params)

    respond_to do |format|
      if @tipo_cancha.save
        format.html { redirect_to @tipo_cancha, notice: 'Tipo cancha was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_cancha }
      else
        format.html { render :new }
        format.json { render json: @tipo_cancha.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_canchas/1
  # PATCH/PUT /tipo_canchas/1.json
  def update
    respond_to do |format|
      if @tipo_cancha.update(tipo_cancha_params)
        format.html { redirect_to @tipo_cancha, notice: 'Tipo cancha was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_cancha }
      else
        format.html { render :edit }
        format.json { render json: @tipo_cancha.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_canchas/1
  # DELETE /tipo_canchas/1.json
  def destroy
    @tipo_cancha.destroy
    respond_to do |format|
      format.html { redirect_to tipo_canchas_url, notice: 'Tipo cancha was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_cancha
      @tipo_cancha = TipoCancha.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_cancha_params
      params.require(:tipo_cancha).permit(:descripcion)
    end
    
    def verify_is_admin
       unless current_user && current_user.admin?
         redirect_to :controller => 'welcome', :action => 'index' 
       end
    end
end
