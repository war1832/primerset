class TipoClientesController < ApplicationController
  before_action :set_tipo_cliente, only: [:show, :edit, :update, :destroy]

  # GET /tipo_clientes
  # GET /tipo_clientes.json
  def index
    @tipo_clientes = TipoCliente.all
  end

  # GET /tipo_clientes/1
  # GET /tipo_clientes/1.json
  def show
  end

  # GET /tipo_clientes/new
  def new
    @tipo_cliente = TipoCliente.new
  end

  # GET /tipo_clientes/1/edit
  def edit
  end

  # POST /tipo_clientes
  # POST /tipo_clientes.json
  def create
    @tipo_cliente = TipoCliente.new(tipo_cliente_params)

    respond_to do |format|
      if @tipo_cliente.save
        format.html { redirect_to @tipo_cliente, notice: 'Tipo cliente was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_cliente }
      else
        format.html { render :new }
        format.json { render json: @tipo_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_clientes/1
  # PATCH/PUT /tipo_clientes/1.json
  def update
    respond_to do |format|
      if @tipo_cliente.update(tipo_cliente_params)
        format.html { redirect_to @tipo_cliente, notice: 'Tipo cliente was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_cliente }
      else
        format.html { render :edit }
        format.json { render json: @tipo_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_clientes/1
  # DELETE /tipo_clientes/1.json
  def destroy
    @tipo_cliente.destroy
    respond_to do |format|
      format.html { redirect_to tipo_clientes_url, notice: 'Tipo cliente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_cliente
      @tipo_cliente = TipoCliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_cliente_params
      params.require(:tipo_cliente).permit(:descripcion)
    end
end
