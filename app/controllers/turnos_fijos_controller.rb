class TurnosFijosController < ApplicationController
  before_action :set_turnos_fijo, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /turnos_fijos
  # GET /turnos_fijos.json
  def index
    @turnos_fijos = TurnosFijo.where fecha_baja: nil
  end

  # GET /turnos_fijos/1
  # GET /turnos_fijos/1.json
  def show
  end

  # GET /turnos_fijos/new
  def new
    @turnos_fijo = TurnosFijo.new
  end

  # GET /turnos_fijos/1/edit
  def edit
  end

  # POST /turnos_fijos
  # POST /turnos_fijos.json
  def create
    @turnos_fijo = TurnosFijo.new(turnos_fijo_params)
    respond_to do |format|
      if @turnos_fijo.save
         Auditorium.GenerarAuditoria("Alta Turno Fijo", current_user.email, nil, @turnos_fijo)
        format.html { redirect_to @turnos_fijo, notice: 'Turnos fijo was successfully created.' }
        format.json { render :show, status: :created, location: @turnos_fijo }
      else
        format.html { render :new }
        format.json { render json: @turnos_fijo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turnos_fijos/1
  # PATCH/PUT /turnos_fijos/1.json
  def update
    turno_fijo_viejo = @turnos_fijo.dup
    respond_to do |format|
      if @turnos_fijo.update(turnos_fijo_params)
        Auditorium.GenerarAuditoria("Modifiacion Turno Fijo", current_user.email, turno_fijo_viejo, @turnos_fijo)
        format.html { redirect_to @turnos_fijo, notice: 'Turnos fijo was successfully updated.' }
        format.json { render :show, status: :ok, location: @turnos_fijo }
      else
        format.html { render :edit }
        format.json { render json: @turnos_fijo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turnos_fijos/1
  # DELETE /turnos_fijos/1.json
  def destroy
    @turnos_fijo.fecha_baja = DateTime.now
    if @turnos_fijo.save
      Auditorium.GenerarAuditoria("Baja Turno Fijo", current_user.email, @turnos_fijo, nil)
      respond_to do |format|
        format.html { redirect_to @turnos_fijo, notice: 'El turno fijo se dio de baja correctamente.' }
        format.json { head :no_content }
      end
    else    
       format.html { render :edit }
       format.json { render json: @turnos_fijo.errors, status: :unprocessable_entity }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_turnos_fijo
    @turnos_fijo = TurnosFijo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def turnos_fijo_params
    params.require(:turnos_fijo).permit(:cliente_id, :cancha_id, :hora_inicio, :hora_fin, :dia_semana)
  end
end
