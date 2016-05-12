json.array!(@activities) do |activity|
  json.extract! activity, :id, :num_hours, :worker_id, :task_id, :observation, :date_activity
  json.url activity_url(activity, format: :json)
end
