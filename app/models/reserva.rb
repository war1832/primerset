class Reserva < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :cancha

  validates_presence_of :fecha_inicio
  validates_presence_of :fecha_fin
  
  validate :validar_reserva
  
  def validar_reserva
      if Reserva.where("(fecha_inicio BETWEEN ? AND ? OR 
                        fecha_fin BETWEEN ? AND ? ) AND  
                        cancha_id = ? AND 
                        fecha_baja IS NULL AND
                        cliente_id <> ? ", (fecha_inicio + 1.seconds), (fecha_fin - 1.seconds),
                                           (fecha_inicio + 1.seconds),(fecha_fin - 1.seconds),
                                            cancha.id, cliente.id  ).present?
        errors.add(:disponibilidad, "Ya existe un Turno en ese horario, verifique los datos de la reserva.")
      end
  end
  
end
