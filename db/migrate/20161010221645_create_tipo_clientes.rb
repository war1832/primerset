class CreateTipoClientes < ActiveRecord::Migration
  def change
    create_table :tipo_clientes do |t|
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
