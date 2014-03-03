json.array!(@corporations) do |corporation|
  json.extract! corporation, :nombre, :ficha, :representante_text, :capital_text, :capital, :moneda, :agente, :notaria, :fecha_registro, :status, :duracion, :provincia
  json.url corporation_url(corporation, format: :json)
end
