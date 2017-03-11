class CreateCancelacionesTurnos < ActiveRecord::Migration
  def change
    create_table :cancelaciones_turnos do |t|
      t.references :turnos_fijo, index: true, foreign_key: true
      t.datetime :fecha_baja
      t.datetime :dia_cancelacion

      t.timestamps null: false
    end
  end
end
