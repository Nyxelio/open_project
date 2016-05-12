json.array!(@families) do |family|
  json.extract! family, :id, :label
  json.url family_url(family, format: :json)
end
