puts <<-EOF

       ,--.          ,--.  ,--.
 ,---. |  |,-. ,---. |  |,-'  '-. ,---. ,--,--,
(  .-' |     /| .-. :|  |'-.  .-'| .-. ||      \
.-'  `)|  \  \\   --.|  |  |  |  ' '-' '|  ||  |
`----' `--'`--'`----'`--'  `--'   `---' `--''--'
  Rails Application Template @ craftpaperbag

EOF

# -----------------------------------------------------------------
# 準備

TEMPLATE_ROOT = File.expand_path('../', __FILE__)
FILES_ROOT = File.expand_path('../files/', __FILE__)

# ファイルパスを渡すと、
# files以下のファイルを
# 作っているrailsアプリ側に配置する
def preset(filepaths = [])
  filepaths = [filepaths] unless filepaths.class == Array
  filepaths.each do |filepath|
    run "cp #{FILES_ROOT}/#{fileapth} ./#{filepath}"
  end
end

# -----------------------------------------------------------------
# Git

run "cp #{FILES_ROOT}/gitignore_template ./.gitignore"

# -----------------------------------------------------------------
# Gemfile

preset 'Gemfile'

# -----------------------------------------------------------------
# configure & bundle install

gen_config <<-EOF
config.generators do |g|
  g.test_framework = "rspec"
  g.controller_specs = false
  g.helper_specs = false
  g.view_specs = false
end
EOF
environment gen_config

run 'bundle install --path=vendor/bundle --without=production'
run 'bundle binstubs rspec-core'
generate 'rspec:install'

# -----------------------------------------------------------------
# Change files & directories

run 'rm -f app/assets/stylesheets/application.css'
run 'rm -rf test'
run 'mkdir app/views/shared'
run 'mkdir spec/features'
run 'rm -f app/views/layouts/application.html.erb'
generate 'controller top index:get'
route "root to: 'top#index'"

preset %w(
  app/assets/application.scss
  app/assets/javascripts/application.js
  app/assets/javascripts/messages.js

  app/controllers/concerns/message_action.rb
  app/controllers/application_controller.rb

  app/views/layouts/application.html.slim
  app/views/top/index.html.slim
  app/views/shared/_messages.html.slim

  app/helpers/application_helper.rb

  spec/rails_helper.rb
  spec/features/top_page_spec.rb

  config/database.yml

  circle.yml
)

puts <<-EOF
      Please:
      - input your copy into 'app/views/layouts/application.html.slim:34'

      If you want to deploy on Heroku with CircleCI:
      - input your heroku app name into 'circle.yml'
      - input your heroku DB information into 'config/database.yml'

      $ bundle exec rails s
      $ open http://localhost:3000
EOF
