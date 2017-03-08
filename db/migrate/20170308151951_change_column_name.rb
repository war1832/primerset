class ChangeColumnName < ActiveRecord::Migration
def change
    rename_column :canchas, :name, :descripcion
  end
end
