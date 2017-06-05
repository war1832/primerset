class CreateAuditoria < ActiveRecord::Migration
  def change
    create_table :auditoria do |t|
      t.string :usuario
      t.string :accion
      t.text :valor_viejo
      t.text :valor_nuevo

      t.timestamps null: false
    end
  end
end
