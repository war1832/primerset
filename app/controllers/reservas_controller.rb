class ReservasController < ApplicationController
  before_action :set_reserva, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def agenda
    @reservas = Reserva.where("DATE(fecha_inicio) = ? AND fecha_baja IS NULL", Date.today).order(:fecha_inicio)
    @turnos_fijos = TurnosFijo.where("fecha_baja IS NULL AND dia_semana = ?", (Date.today.wday-1)).order(:hora_inicio)
  end

  # GET /reservas
  # GET /reservas.json
  def index
    @reservas = Reserva.where fecha_baja: nil
    @cancelaciones =  Reserva.where.not fecha_baja: nil
  end

  # GET /reservas/1
  # GET /reservas/1.json
  def show
  end

  # GET /reservas/new
  def new
    @reserva = Reserva.new
  end

  # GET /reservas/1/edit
  def edit
  end

  # POST /reservas
  # POST /reservas.json
  def create
    @reserva = Reserva.new(reserva_params)
    respond_to do |format|
      if @reserva.save
         ClienteMailer.recordatorio_reserva(@reserva).deliver_later
         Auditorium.GenerarAuditoria("Alta Reserva", current_user.email, nil, @reserva)
        format.html { redirect_to @reserva, notice: 'Reserva was successfully created.' }
        format.json { render :show, status: :created, location: @reserva }
      else
        format.html { render :new }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservas/1
  # PATCH/PUT /reservas/1.json
  def update
    reserva_vieja = @reserva.dup
    respond_to do |format|
      if @reserva.update(reserva_params)
         Auditorium.GenerarAuditoria("Modificacion Reserva", current_user.email, reserva_vieja, @reserva)
        format.html { redirect_to @reserva, notice: 'Reserva was successfully updated.' }
        format.json { render :show, status: :ok, location: @reserva }
      else
        format.html { render :edit }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservas/1
  # DELETE /reservas/1.json
  def destroy
    @reserva.fecha_baja = DateTime.now
    if @reserva.save
      respond_to do |format|
        Auditorium.GenerarAuditoria("Baja Reserva", current_user.email, @reserva, nil)
        format.html { redirect_to @reserva, notice: 'La reserva se dio de baja correctamente.' }
        format.json { head :no_content }
      end
    else    
       format.html { render :edit }
       format.json { render json: @reserva.errors, status: :unprocessable_entity }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserva
      @reserva = Reserva.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reserva_params
      params.require(:reserva).permit(:cliente_id, :cancha_id, :fecha_inicio, :fecha_fin, :fecha_baja)
    end

    def agenda_params
       params.require(:reserva).permit(:date)
    end
end
