json.extract! turnos_fijo, :id, :cliente_id, :cancha_id, :hora_inicio, :hora_fin, :dia_semana, :created_at, :updated_at
json.url turnos_fijo_url(turnos_fijo, format: :json)