# frozen_string_literal: true

json.extract! comic, :id, :title, :release_date, :description, :created_at, :updated_at
json.url comic_url(comic, format: :json)
