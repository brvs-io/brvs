# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Rails
gem 'actionmailer', '~> 6.0'
gem 'actionpack', '~> 6.0'
gem 'actionview', '~> 6.0'
gem 'activejob', '~> 6.0'
gem 'activemodel', '~> 6.0'
gem 'activerecord', '~> 6.0'
gem 'activesupport', '~> 6.0'
gem 'bootsnap', '~> 1.4', require: false
gem 'puma', '~> 4.1'
gem 'rails-i18n', '~> 6.0'
gem 'railties', '~> 6.0.3'
gem 'tzinfo-data', '~> 1.2020.1'

# Databases
gem 'pg', '~> 1.2'

# Frontend
gem 'flutie', '~> 2.2'
gem 'turbolinks', '~> 5.2'
gem 'webpacker', '~> 5.1'

# Background jobs
gem 'delayed_job_active_record', '~> 4.1'

# Profiling
gem 'flamegraph', '~> 0.9'
gem 'memory_profiler', '~> 0.9'
gem 'rack-mini-profiler', '~> 2.0'
gem 'rbtrace', '~> 0.4'
gem 'stackprof', '~> 0.2'

# Utilities
gem 'pry-rails', '~> 0.3'

# Security
gem 'devise', '~> 4.7'
gem 'doorkeeper', '~> 5.4'
gem 'rack-attack', '~> 6.3'

# Validations
gem 'validate_url', '~> 1.0'

# Short ID generation
gem 'hashids', '~> 1.0'

# Pagination
gem 'kaminari', '~> 1.2'

# Presentation
gem 'local_time', '~> 2.1'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.13'
  gem 'pry-byebug', '~> 3.9'
  gem 'rspec-rails', '~> 4.0'
end

group :development do
  gem 'annotate', '~> 3.1', require: false
  gem 'brakeman', '~> 4.9', require: false
  gem 'bundler-audit', '~> 0.7', require: false
  gem 'i18n-tasks', '~> 0.9', require: false
  gem 'listen', '~> 3.2'
  gem 'rubocop', '~> 0.88', require: false
  gem 'rubocop-faker', '~> 1.1', require: false
  gem 'rubocop-performance', '~> 1.7', require: false
  gem 'rubocop-rails', '~> 2.7', require: false
  gem 'rubocop-rspec', '~> 1.42', require: false
  gem 'spring', '~> 2.1'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'spring-commands-rubocop', '~> 0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'coveralls', '~> 0.8', require: false
end
