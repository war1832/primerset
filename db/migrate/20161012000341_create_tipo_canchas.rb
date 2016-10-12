class CreateTipoCanchas < ActiveRecord::Migration
  def change
    create_table :tipo_canchas do |t|
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
