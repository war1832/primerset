class TurnosFijo < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :cancha
  has_many :cancelaciones_turno
    
  validates_presence_of :hora_inicio
  validates_presence_of :hora_fin
  
  validate :validar_turno_fijo
  validate :validar_horario
  
  def validar_turno_fijo
      if verificar_disponibilidad_turnos_fijos && verificar_disponibilidad_reservas
        errors.add(:disponibilidad, "Ya existe un Turno en ese horario, verifique los datos de la reserva.")
      end
  end
  
 def verificar_disponibilidad_reservas

  Reserva.where("fecha_inicio >= ? AND
        WEEKDAY(fecha_inicio) = ?  AND 
      (HOUR(fecha_inicio) BETWEEN ? AND ? OR 
       HOUR(fecha_fin) BETWEEN ? AND ? ) AND  
                     cancha_id = ? AND 
                fecha_baja IS NULL AND
                      cliente_id <> ?", DateTime.now, dia_semana ,(hora_inicio + 1.seconds).strftime("%H:%M"), (hora_fin - 1.seconds).strftime("%H:%M"),
                                           (hora_inicio + 1.seconds).strftime("%H:%M"),(hora_fin - 1.seconds).strftime("%H:%M"),
                                            cancha.id, cliente.id  ).present?
 end
 
  def verificar_disponibilidad_turnos_fijos
    TurnosFijo.where("(HOUR(hora_inicio) BETWEEN ? AND ? OR 
                        HOUR(hora_fin) BETWEEN ? AND ? ) AND 
                        dia_semana = ? AND  
                        cancha_id = ? AND 
                        fecha_baja IS NULL AND
                        cliente_id <> ? ", (hora_inicio + 1.seconds).strftime("%H:%M"), (hora_fin - 1.seconds).strftime("%H:%M"),
                                           (hora_inicio + 1.seconds).strftime("%H:%M"), (hora_fin - 1.seconds).strftime("%H:%M"),
                                           dia_semana, cancha.id, cliente.id  ).present?
  end
  
  def validar_horario
    errors.add(:horario_incorrecto, "Verifique los horarios.") if hora_inicio.strftime("%H:%M") > hora_fin.strftime("%H:%M")
  end
end
