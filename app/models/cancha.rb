class Cancha < ActiveRecord::Base
  belongs_to :TipoCancha
  has_many :reservas
  
  def descripcion_con_tipo
    "#{self.TipoCancha.descripcion} - #{name}"
  end
end
