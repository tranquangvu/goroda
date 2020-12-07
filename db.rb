# frozen_string_literal: true

require 'sequel/core'

DB = Sequel.connect(
  adapter: :postgres,
  host: ENV['DB_HOST'],
  port: ENV['DB_PORT'],
  user: ENV['DB_USER'],
  password: ENV['DB_PASSWORD'],
  database: ENV['DB_NAME'],
  max_connections: ENV['DB_MAX_CONNECTIONS']
)
