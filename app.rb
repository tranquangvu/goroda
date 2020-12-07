# frozen_string_literal: true

require 'roda'
require_relative 'models'

class App < Roda
  plugin :default_headers, {
    'Content-Type' => 'application/json',
    'X-Frame-Options' => 'deny',
    'X-Content-Type-Options' => 'nosniff',
    'X-XSS-Protection' => '1; mode=block'
  }
  plugin :hash_routes
  plugin :head
  plugin :json, classes: [Array, Hash, Sequel::Model], content_type: 'application/json'
  plugin :json_parser
  plugin :all_verbs
  plugin :halt
  plugin :common_logger, ENV['RACK_ENV'] == 'test' ? Class.new { def write(_) end }.new : $stderr

  Unreloader.require('controllers') {}

  route do |r|
    r.root do
      { success: true, message: 'Application server is up', env: ENV['RACK_ENV'] }
    end
    r.hash_routes
  end
end
