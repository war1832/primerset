class CreateTurnosFijos < ActiveRecord::Migration
  def change
    create_table :turnos_fijos do |t|
      t.references :cliente, index: true, foreign_key: true
      t.references :cancha, index: true, foreign_key: true
      t.datetime :hora_inicio
      t.datetime :hora_fin
      t.integer :dia_semana

      t.timestamps null: false
    end
  end
end
