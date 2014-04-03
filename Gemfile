source 'https://rubygems.org'

# gem "sprockets", "2.11.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem "lazyload-rails"

gem 'gon'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Bower Manager => https://rails-assets.org/
source 'https://rails-assets.org'

# turbolinks support
gem 'jquery-turbolinks'

# Source Map
gem 'coffee-rails-source-maps'
# gem 'sass-rails-source-maps'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# CSS Support
gem 'less-rails'

# App Server
gem 'puma'

# Presenter Layer
gem 'draper'

# Haml
gem 'slim-rails'

# Assets log cleaner
gem 'quiet_assets'

# Form Builders
gem 'simple_form'

# # Process Management
gem 'foreman'

# HTML5 Validator
gem 'html5_validators'

# PG/MySQL Log Formatter
gem 'rails-flog'

# Migration Helper
gem 'migrant'

# Pagenation
gem 'kaminari'

# NewRelic
gem 'newrelic_rpm'

# Airbrake
gem 'airbrake'

# HTML Parser
gem 'nokogiri'

# App configuration
gem 'figaro'

# Rack Profiler
gem 'rack-mini-profiler'

# Hash extensions
gem 'hashie'

# Google Play scraper
gem 'market_bot'

# Http Wrapper for Rest
gem 'rest-client'

gem 'bootstrap-sass', '3.0.2.0'

gem 'yoyakutopten_scraper'

group :development do
  # Converter erb => haml
  gem 'erb2haml'

  # ER diagram generator
  gem "rails-erd"
end

group :development, :test do
  # Rails application preloader
  gem 'spring'

  gem 'spring-commands-rspec'

  gem 'simplecov', :require=>false

  # Railsコンソールの多機能版
  gem 'pry-rails'

  # pryの入力に色付け
  gem 'pry-coolline'

  # デバッカー
  gem 'pry-byebug'

  # Pryでの便利コマンド
  gem 'pry-doc'

  # PryでのSQLの結果を綺麗に表示
  gem 'hirb'
  gem 'hirb-unicode'

  # pryの色付けをしてくれる
  gem 'awesome_print'

  # Rspec
  gem 'rspec-rails'
  gem 'rake_shared_context'

  # fixtureの代わり
  gem "factory_girl_rails"

  # テスト環境のテーブルをきれいにする
  gem 'database_rewinder'

  # Guard
  gem 'guard-rspec'
  gem 'guard-spring'
end

group :production, :staging do
  # ログ保存先変更、静的アセット Heroku 向けに調整
  gem 'rails_12factor'
end
