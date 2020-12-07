# frozen_string_literal: true

require 'dotenv'

ENV['RACK_ENV'] ||= 'development'
Dotenv.load(".env.#{ENV['RACK_ENV']}", '.env')

run_migrate = lambda do |version|
  require_relative '../../db'
  require 'logger'

  Sequel.extension(:migration)
  DB.loggers << Logger.new($stdout) if DB.loggers.empty?
  Sequel::Migrator.run(DB, 'migrations', target: version, use_transactions: true)
end

get_migrate_version = lambda do
  require_relative '../../db'

  DB.tables.include?(:schema_info) ? DB[:schema_info].first[:version] : 0
end

namespace :db do
  task :migrate do
    run_migrate.call(nil)
  end

  task :rollback, :version do |_, args|
    version = get_migrate_version.call
    args.with_defaults(version: version.zero? && version || version - 1)
    run_migrate.call(args[:version].to_i)
  end

  task :version do
    version = get_migrate_version.call
    puts "Migrate version: #{version}"
  end

  task :create do
    puts "=> Create database #{ENV['DB_NAME']}"
    Process.wait Process.spawn(
      {
        'PGPASSWORD' => ENV['DB_PASSWORD']
      },
      'createdb',
      "--host=#{ENV['DB_HOST'] || 'localhost'}",
      "--port=#{ENV['DB_PORT'] || '5432'}",
      "--username=#{ENV['DB_USER'] || 'postgres'}",
      "--encoding=#{ENV['DB_ENCODING'] || 'utf8'}",
      ENV['DB_NAME']
    )
  end

  task :drop do
    puts "=> Drop database #{ENV['DB_NAME']}"
    Process.wait Process.spawn(
      {
        'PGPASSWORD' => ENV['DB_PASSWORD']
      },
      'dropdb',
      "--host=#{ENV['DB_HOST'] || 'localhost'}",
      "--port=#{ENV['DB_PORT'] || '5432'}",
      "--username=#{ENV['DB_USER'] || 'postgres'}",
      ENV['DB_NAME']
    )
  end
end
