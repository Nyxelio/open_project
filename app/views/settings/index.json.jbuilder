json.array!(@settings) do |setting|
  json.extract! setting, :id, :label, :value
  json.url setting_url(setting, format: :json)
end
