class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :apellido
      t.string :direccion
      t.string :telefono

      t.timestamps null: false
    end
  end
end
