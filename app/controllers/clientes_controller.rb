class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!
  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    @ultimas_reservas =  @cliente.Reservas.where(fecha_baja: nil).last(5)
    @reservas = @cliente.Reservas.count
    @cancelaciones = @cliente.Reservas.where("fecha_baja IS NOT NULL").count
  end

  def consulta
     filtro = date = params[:filter]

     @clientes = [];

     unless filtro.empty?
      @clientes += Cliente.where("nombre LIKE ? OR apellido LIKE ?", filtro, filtro)
     else
      redirect_to :controller => 'clientes', :action => 'index'
    end

  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    respond_to do |format|
      if @cliente.save
         Auditorium.GenerarAuditoria("Alta Cliente", current_user.email, nil, @cliente)
        format.html { redirect_to @cliente, notice: 'Cliente was successfully created.' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    cliente_viejo =  @cliente.dup
    respond_to do |format|
      if @cliente.update(cliente_params)
         Auditorium.GenerarAuditoria("Modifiacion de Cliente", current_user.email, cliente_viejo, @cliente)
        format.html { redirect_to @cliente, notice: 'Cliente was successfully updated.' }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente.destroy
    respond_to do |format|
      Auditorium.GenerarAuditoria("Baja de Cliente", current_user.email, @cliente, nil)
      format.html { redirect_to clientes_url, notice: 'Cliente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cliente_params
      params.require(:cliente).permit(:nombre, :apellido, :direccion, :telefono, :email, :tipo_cliente_id)
    end
end
