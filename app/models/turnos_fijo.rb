class TurnosFijo < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :cancha
end
