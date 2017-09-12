class ClienteMailer < ApplicationMailer
  default from: 'club@primerset.com.ar'
 
  def recordatorio_reserva(reserva)
    @reserva = reserva
    email = reserva.cliente.email
    mail(to: email, subject: 'Recordatorio de turno')
  end
end
