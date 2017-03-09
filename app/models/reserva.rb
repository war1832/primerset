class Reserva < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :cancha

  validates_presence_of :fecha_inicio
  validates_presence_of :fecha_fin
  
  validate :validar_horario
  validate :validar_reserva
  
  def validar_reserva
      if verificar_disponibilidad_turnos_fijos || verificar_disponibilidad_reservas
        errors.add(:disponibilidad, "Ya existe un Turno en ese horario, verifique los datos de la reserva.")
      end
  end
  
  def verificar_disponibilidad_reservas
    Reserva.where("(fecha_inicio BETWEEN ? AND ? OR 
                    fecha_fin BETWEEN ? AND ? ) AND  
                    cancha_id = ? AND 
                    fecha_baja IS NULL AND
                    cliente_id <> ? ", (fecha_inicio + 1.seconds), (fecha_fin - 1.seconds),
                                       (fecha_inicio + 1.seconds),(fecha_fin - 1.seconds),
                                        cancha.id, cliente.id  ).present?
 end
 
  def verificar_disponibilidad_turnos_fijos
      TurnosFijo.where("(HOUR(hora_inicio) BETWEEN ? AND ? OR 
                         HOUR(hora_fin) BETWEEN ? AND ? ) AND 
                         dia_semana = ? AND  
                         cancha_id = ? AND 
                         fecha_baja IS NULL AND
                         cliente_id <> ? ", (fecha_inicio + 1.seconds).strftime("%H:%M"), (fecha_fin - 1.seconds).strftime("%H:%M"),
                                            (fecha_inicio + 1.seconds).strftime("%H:%M"), (fecha_fin - 1.seconds).strftime("%H:%M"),
                                            fecha_inicio.wday, cancha.id, cliente.id  ).present?
  end
  
  def validar_horario    
    if (fecha_inicio > fecha_fin) || fecha_inicio.to_date != fecha_fin.to_date
      errors.add(:horario_incorrecto, "Verifique los horarios.") 
    end 
  end
  
end
