# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

begin
  # Load up the environment instead of just the boot file because we want all of the tasks available.
  require File.join(File.dirname(__FILE__), 'config', 'environment')
rescue Exception
  # Log the exception to the console/logfile.
  puts "*** Couldn't load the application's configuration because something went wrong... ***"
  puts "*** Don't worry, we'll bypass the application's configuration and just boot instead... ***"

  # Load up the boot file instead because there's something wrong with the environment.
  require File.join(File.dirname(__FILE__), 'config', 'boot')
end

# Require the standard stuff
require 'rake/dsl_definition'
require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'tasks/rails'

require 'refinery/tasks/refinery'