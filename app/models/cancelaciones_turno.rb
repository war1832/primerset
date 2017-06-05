class CancelacionesTurno < ActiveRecord::Base
  belongs_to :turnos_fijo

  def as_json(options={})
    super(options).reject { |k, v| v.nil? }
  end
end
