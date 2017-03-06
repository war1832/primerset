class CreateReservas < ActiveRecord::Migration
  def change
    create_table :reservas do |t|
      t.references :cliente, index: true, foreign_key: true
      t.references :cancha, index: true, foreign_key: true
      t.datetime :fecha_inicio
      t.datetime :fecha_fin
      t.datetime :fecha_baja

      t.timestamps null: false
    end
  end
end
