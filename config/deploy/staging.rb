# Set staging variables

set :rails_env, "staging"

set :config, YAML::load(File.read(File.join(project_root, "config", 'database.yml')))["#{rails_env}"]

# Set SSH specific options for deployment
set :use_sudo, false                                    	 # should we use sudo? This may change in future
ssh_options[:username] = "deploy"                            # ssh user 
set :user, "deploy"                                          # system user 
set :runner, "deploy"                                        # user to run commands 

set :site_domain, "#{app_data['application']}.webfirmdemo.com"

server 'staging.webfirmdemo.com', :app, :web, :db, :primary => true

# Set deploy location 
set :deploy_to, "/home/deploy/apps/#{application}"

