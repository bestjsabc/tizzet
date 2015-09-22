# Load the rails application
#
RAILS_GEM_VERSION = '2.3.15'

#ENV['RAILS_ENV'] = 'production'

#
#
require File.expand_path('../application', __FILE__)
ActionView::Base.field_error_proc = proc { |input, instance| input } 

#RAILS_GEM_VERSION = '2.3.15' unless defined? RAILS_GEM_VERSION



