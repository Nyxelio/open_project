json.array!(@workers) do |worker|
  json.extract! worker, :id, :firstname, :lastname, :cost_hour
  json.url worker_url(worker, format: :json)
end
