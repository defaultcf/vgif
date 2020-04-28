# frozen_string_literal: true

json.extract! gif, :id, :title, :source_url, :user_id, :public, :created_at, :updated_at
json.url gif_url(gif, format: :json)
