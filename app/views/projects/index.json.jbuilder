json.array!(@projects) do |project|
  json.extract! project, :id, :name, :is_close, :estimated_start_at, :estimated_end_at, :estimated_duration, :real_start_at, :real_end_at, :real_duration, :difference_hour
  json.url project_url(project, format: :json)
end
