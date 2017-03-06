class Cliente < ActiveRecord::Base
    belongs_to :Tipo_cliente
    has_many :Reservas
end
