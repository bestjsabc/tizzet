# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.15' unless defined? RAILS_GEM_VERSION

# Specified gem version of Refinery to use when vendor/plugins/refinery/lib/refinery.rb is not present.
REFINERY_GEM_VERSION = '0.9.6.20' unless defined? REFINERY_GEM_VERSION

#ENV['RAILS_ENV'] = 'production'

# Boot Rails
require File.join(File.dirname(__FILE__), 'boot')

# Here we load in Refinery to do the rest of the heavy lifting.
# Refinery is setup in config/preinitializer.rb
require Refinery.root.join("lib", "refinery_initializer").cleanpath.to_s

# Boot with Refinery. Most configuration is handled by Refinery.
# Anything you specify here that Refinery specified internally will override Refinery.
Refinery::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.
  APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/app_config.yml")[RAILS_ENV]

  config.action_controller.session = {
    :session_key => '_refinery_session',
    :secret      => 'eec8fffc3637c05895f8e6a355179eaad0003ac5617e5368955baf7989e1faca4d8ab37140d690c20b05d5815609b7c680c644277b6a892be316a85c6596d75c'
  }
  config.active_record.observers = :user_observer

  # (create the session table with 'rake db:sessions:create')
  config.action_controller.session_store = :active_record_store
  

  # Specify your application's gem requirements here. See the example below:
  # config.gem "refinerycms-news", :lib => "news", :version => "~> 0.9.6"
  # config.gem "refinerycms-portfolio", :lib => "portfolio", :version => "~> 0.9.3.8"
end
