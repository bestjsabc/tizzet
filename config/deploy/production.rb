# Set production variables

set :rails_env, "production"

set :config, YAML::load(File.read(File.join(project_root, "config", 'database.yml')))["#{rails_env}"]

# Set SSH specific options for deployment
set :use_sudo, false                                    	 # should we use sudo? This may change in future
ssh_options[:username] = "deploy"                            # ssh user 
set :user, "deploy"                                          # system user 
set :runner, "deploy"                                        # user to run commands 

#Set domain information for configuration
set :site_domain, app_data['live_domain']

server 'prodweb01.aws.webfirm.com', :app, :web, :db, :primary => true

# Set deploy location 
set :deploy_to, "/home/deploy/apps/#{application}"
