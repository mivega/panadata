json.array!(@asociations) do |asociation|
  json.extract! asociation, :persona_id, :sociedad_id, :rol
  json.url asociation_url(asociation, format: :json)
end
