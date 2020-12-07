# frozen_string_literal: true

task :annotate do
  ENV['RACK_ENV'] = 'development'
  require_relative '../../models'

  DB.loggers.clear

  require 'sequel/annotate'
  Sequel::Annotate.annotate(Dir['models/*.rb'], position: :before)
end
