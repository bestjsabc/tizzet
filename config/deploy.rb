# setup for Multistage environment
set :stages, %w(production staging)
set :default_stage, "staging"

require 'capistrano/ext/multistage'

# Run bundler on deploy
# Gems installed to /apps/redgum/shared/bundle

require "bundler/capistrano"

# Grabs configurating information from the config/deployment YAML file and sets it up for Capistrano.

set :app_data, YAML.load(File.read(File.join(project_root, "config", "deployment.yml"))) unless exists?(:app_data)

set :application, app_data['application']
set :repository,  "\"#{app_data['repository']}\""

# Set source code management software git/svn
set :scm, :subversion

# Set SCM checkout to be via a local cached copy (Speeding up deployments)
# Cached copy stored in shared/cached-copy

set :deploy_via, :remote_cache
