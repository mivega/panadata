json.array!(@owner_brands) do |owner_brand|
  json.extract! owner_brand, 
  json.url owner_brand_url(owner_brand, format: :json)
end
