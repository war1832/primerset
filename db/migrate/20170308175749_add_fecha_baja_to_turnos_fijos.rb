class AddFechaBajaToTurnosFijos < ActiveRecord::Migration
  def change
    add_column :turnos_fijos, :fecha_baja, :datetime
  end
end
