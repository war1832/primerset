class TipoCliente < ActiveRecord::Base
    has_many :Clientes
end
