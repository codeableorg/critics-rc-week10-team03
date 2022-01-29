json.extract! critic, :id, :title, :body, :user_id, :criticable_id, :criticable_type, :created_at,
              :updated_at
json.url critic_url(critic, format: :json)
