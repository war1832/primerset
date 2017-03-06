json.extract! reserva, :id, :cliente_id, :cancha_id, :fecha_inicio, :fecha_fin, :fecha_baja, :created_at, :updated_at
json.url reserva_url(reserva, format: :json)