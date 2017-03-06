class Reserva < ActiveRecord::Base
  belongs_to :Cliente
  belongs_to :Cancha

  validates_presence_of :fecha_inicio
  validates_presence_of :fecha_fin

end
