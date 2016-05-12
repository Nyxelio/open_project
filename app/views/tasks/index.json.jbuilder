json.array!(@tasks) do |task|
  json.extract! task, :id, :code, :label, :estimated_start_at, :estimated_end_at, :estimated_duration, :real_start_at, :real_end_at, :real_duration, :percent_progress, :ratio
  json.url task_url(task, format: :json)
end
