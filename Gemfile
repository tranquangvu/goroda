# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'dotenv'
gem 'puma', '~> 5.1'
gem 'rack-unreloader'
gem 'rake'
gem 'refrigerator'
gem 'roda', '~> 3.38'
gem 'sequel', '~> 5.39'
gem 'sequel_pg', '~> 1.14'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'sequel-annotate'
end

group :test do
  gem 'warning'
end
