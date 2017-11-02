class TurnosFijo < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :cancha
  has_many :cancelaciones_turno
    
  validates_presence_of :hora_inicio
  validates_presence_of :hora_fin
  
  validate :validar_turno_fijo
  validate :validar_horario

  @@dias = {1 => "Lunes", 2=> "Martes",3=> "Miercoles", 4=> "Jueves", 5=>"Viernes", 6=> "Sabado", 0=> "Domingo"}
  
  def descripcion
      "Dia: #{@@dias[dia_semana]} - #{self.cliente.nombre_y_apellido} - #{self.cancha.descripcion}  "
  end

  def dia_con_descripcion
      @@dias[dia_semana]
  end
  
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

  def as_json(options={})
    super(options).reject { |k, v| v.nil? }
  end
end
