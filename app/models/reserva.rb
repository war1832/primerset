class Reserva < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :cancha

  validates_presence_of :fecha_inicio
  validates_presence_of :fecha_fin

end
