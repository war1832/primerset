class Cancha < ActiveRecord::Base
  belongs_to :TipoCancha
  has_many :reservas
end
