class Cliente < ActiveRecord::Base
    belongs_to :tipo_cliente
    has_many :Reservas
    
    validates :nombre, presence: true
    validates :apellido, presence: true
    validates :telefono, presence: true
    
    validates_format_of :email,:with => Devise::email_regexp
    
    
    def nombre_y_apellido
      "#{apellido}, #{nombre}"
    end
end
