class AddColumnToCliente < ActiveRecord::Migration
  def change
    add_column :clientes, :tipo_cliente_id, :integer
    add_index  :clientes, :tipo_cliente_id
  end
end
