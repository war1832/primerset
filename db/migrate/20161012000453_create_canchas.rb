class CreateCanchas < ActiveRecord::Migration
  def change
    create_table :canchas do |t|
      t.string :name
      t.belongs_to :TipoCancha, index: true

      t.timestamps null: false
    end
  end
end
