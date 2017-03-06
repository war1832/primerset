class Cliente < ActiveRecord::Base
    belongs_to :Tipo_cliente
    has_many :Reservas
    
    def nombre_y_apellido
      "#{apellido}, #{nombre}"
    end
end
