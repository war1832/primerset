class CancelacionesTurnosController < ApplicationController
    before_action :set_cancelacion_turno, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!
    
  # GET /tipo_canchas
  # GET /tipo_canchas.json
  def index
    @cancelaciones = CancelacionesTurno.all
  end

  # GET /tipo_canchas/1
  # GET /tipo_canchas/1.json
  def show
  end

  # GET /tipo_canchas/new
  def new
    @cancelacion = CancelacionesTurno.new
  end

  # GET /tipo_canchas/1/edit
  def edit
  end

  # POST /tipo_canchas
  # POST /tipo_canchas.json
  def create
    @cancelacion = CancelacionesTurno.new(cancelaciones_turno_params)
    @cancelacion.fecha_baja = DateTime.now
    
    respond_to do |format|
      if @cancelacion.save
        format.html { redirect_to @cancelacion, notice: 'Cancelacion was successfully created.' }
        format.json { render :show, status: :created, location: @cancelacion }
      else
        format.html { render :new }
        format.json { render json: @cancelacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_canchas/1
  # PATCH/PUT /tipo_canchas/1.json
  def update
    respond_to do |format|
      if @cancelacion.update(cancelaciones_turno_params)
        format.html { redirect_to @cancelacion, notice: 'Cancelacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_cancha }
      else
        format.html { render :edit }
        format.json { render json: @cancelacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_canchas/1
  # DELETE /tipo_canchas/1.json
  def destroy
    @cancelacion.destroy
    respond_to do |format|
      format.html { redirect_to tipo_canchas_url, notice: 'Cancelacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cancelacion_turno
      @cancelacion = CancelacionesTurno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cancelaciones_turno_params
      params.require(:cancelaciones_turno).permit(:dia_cancelacion, :turnos_fijo_id)
    end

end