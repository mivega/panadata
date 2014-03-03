json.array!(@owners) do |owner|
  json.extract! owner, 
  json.url owner_url(owner, format: :json)
end
