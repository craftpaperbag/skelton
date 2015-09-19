# -----------------------------------------------------------------
# Git

# TODO git ignore を配置
# TODO README.md を配置

# -----------------------------------------------------------------
# Gem

# TODO ruby バージョンを明記

gem_group :test, :development do
  gem 'rspec-rails'
  gem 'capybara-rails'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'sqlite3'
end

gem_group :development do
  gem 'spring'
end

gem 'bootstrap-sass'
gem 'sass-rails'
gem 'slim-rails'
gem 'unicorn-rails'
gem 'turbolinks'

gem_group :production do
  gem 'pg'
end

# -----------------------------------------------------------------
# for Rspec

# TODO config/application.rbに作らないテストを追記
config = <<-EOF
config.generators do |g|
  g.test_framework = "rspec"
  g.controller_specs = false
  g.helper_specs = false
  g.view_specs = false
end
EOF

run 'bundle install --path=vendor/bundle --without=production'
run 'bundle binstubs rspec-core'
run 'rm -rf test'
generate 'rspec:install'
# TODO rails_helper.rb に追記
"config.include FactoryGirl::Syntax::Methods"

# TODO spec/features/top_page_spec.rb を配置

# -----------------------------------------------------------------
# for Bootstrap & first controller

# TODO application.css->application.scssにして、中身を整理
# TODO application.jsを置き換え
run 'rm app/assets/stylesheets/application.css'

# TODO MessageActionを配置
# TODO ApplicationControllerを置き換え
# TODO views/shared/_messages.html.slimを配置
# TODO views/layouts/application.html.erb を 消す
# TODO views/layouts/application.html.slim を 配置

generate 'controller top index'
# TODO ルーティングを追加 root -> 'top#index'
# TODO app/views/top/index.html.slim を置き換え


# -----------------------------------------------------------------
# for CircleCI

# TODO circle.ymlを配置

# -----------------------------------------------------------------
# for Heroku


# TODO database.ymlを配置
# TODO secrets.ymlを生成
