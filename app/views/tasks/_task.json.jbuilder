json.extract! task, :id, :name, :category_id, :created_at, :updated_at
json.url task_url(task, format: :json)
