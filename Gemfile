# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Rails
gem 'bootsnap', '~> 1.4', require: false
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3'
gem 'tzinfo-data', '~> 1.2020.1'

# Databases
gem 'pg', '~> 1.2'

# Frontend
gem 'sass-rails', '~> 6.0'
gem 'turbolinks', '~> 5.2'
gem 'webpacker', '~> 5.1'

group :development, :test do
  gem 'byebug', '~> 11.1'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.13'
  gem 'rspec-rails', '~> 4.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
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
