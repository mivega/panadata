json.array!(@licitations) do |licitation|
  json.extract! licitation, :url, :visited, :parsed, :category_id, :compra_type, :entidad, :dependencia, :nombre_contacto, :telefono_contacto, :correo_contacto, :objeto, :modalidad, :unidad, :provincia, :precio, :proponente, :description, :acto, :fecha
  json.url licitation_url(licitation, format: :json)
end
