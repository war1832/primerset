class Auditorium < ActiveRecord::Base

    def self.GenerarAuditoria (accion, usuario, valor_viejo, valor_nuevo)
      begin
        auditoria = Auditorium.new
        auditoria.accion = accion
        auditoria.valor_viejo = valor_viejo.as_json
        auditoria.valor_nuevo = valor_nuevo.as_json
        auditoria.usuario = usuario
        auditoria.save
      end
     rescue Exception => msg  
      puts msg
    end

end
