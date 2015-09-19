puts <<-EOF
                                                 
       ,--.          ,--.  ,--.                  
 ,---. |  |,-. ,---. |  |,-'  '-. ,---. ,--,--,  
(  .-' |     /| .-. :|  |'-.  .-'| .-. ||      \ 
.-'  `)|  \  \\   --.|  |  |  |  ' '-' '|  ||  | 
`----' `--'`--'`----'`--'  `--'   `---' `--''--' 
                                                 
Rails Application Template @ craftpaperbag

EOF

TEMPLATE_ROOT = File.expand_path('../', __FILE__)
FILES_ROOT = File.expand_path('../files/', __FILE__)
# -----------------------------------------------------------------
# Git

run "cp #{FILES_ROOT}/gitignore_template ./.gitignore"

# -----------------------------------------------------------------
# Gem

run "cp #{FILES_ROOT}/Gemfile ."

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
run 'rm -rf test'
generate 'rspec:install'
run "cp #{FILES_ROOT}/rails_helper.rb ./spec/"
run 'mkdir spec/features'

# -----------------------------------------------------------------
# First controller

run 'rm -f app/assets/stylesheets/application.css'
run "cp #{FILES_ROOT}/assets/application.scss app/assets/stylesheets/"

run "cp #{FILES_ROOT}/assets/application.js app/assets/javascripts/"
run "cp #{FILES_ROOT}/assets/messages.js app/assets/javascripts/"

run "cp #{FILES_ROOT}/concerns/message_action.rb app/controllers/concerns/"

run "cp #{FILES_ROOT}/controllers/application_controller.rb app/controllers/"

run "mkdir app/views/shared"
run 'rm -f app/views/layouts/application.html.erb'
run "cp #{FILES_ROOT}/views/shared/_messages.html.slim app/views/shared/"
run "cp #{FILES_ROOT}/views/layouts/application.html.slim app/views/layouts/"

run "cp #{FILES_ROOT}/helpers/application_helper.rb app/helpers/"

generate 'controller top index:get'
route "root to: 'top#index'"
run "cp #{FILES_ROOT}/views/top/index.html.slim app/views/top/"

run "cp #{FILES_ROOT}/spec/top_page_spec.rb ./spec/features/"


# -----------------------------------------------------------------
# for CircleCI

run "cp #{FILES_ROOT}/circle.yml ."

# -----------------------------------------------------------------
# for Heroku


run "cp #{FILES_ROOT}/config/database.yml config/"
# TODO secrets.ymlを生成
