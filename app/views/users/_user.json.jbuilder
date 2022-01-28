json.extract! user, :id, :username, :role, :critics_count, :created_at, :updated_at
json.url user_url(user, format: :json)
