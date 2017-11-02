class CancelacionesTurno < ActiveRecord::Base
  belongs_to :turnos_fijo

  validate :validar_cancelacion

  def validar_cancelacion
      if verificar_dia == false
        errors.add(:error, " ,no se puede realizar la cancelacion en ese dia, verifique los datos del turno fijo.")
      end
  end

  def verificar_dia
    dia_cancelacion.wday  == turnos_fijo.dia_semana
  end

  def as_json(options={})
    super(options).reject { |k, v| v.nil? }
  end
end
