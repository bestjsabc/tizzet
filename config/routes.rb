ActionController::Routing::Routes.draw do |map|

  # Authentication routes
  map.resources :users
  map.resource :session
  map.resources :payment_notifications

  map.namespace(:admin) do |admin|
    admin.resources :users
  end

  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.forgot '/forgot', :controller => 'users', :action => 'forgot'
  map.reset 'reset/:reset_code', :controller => 'users', :action => 'reset'

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.connect '/search/:query', :controller => 'search', :action => 'index'
  map.connect '/search/:query.:format', :controller => 'search', :action => 'index'
  map.search '/search', :controller => 'search', :action => 'index'
  map.account '/my_account', :controller => 'users', :action => 'show'
  
  map.resources :users
  map.resources :tickets, :member => { :buy => :get }
  map.resources :orders
  map.resource :session

  # NB: Engine routes are loaded FIRST from Rails v2.3 onward.
  # These routes are contained within vendor/plugins/engine_name/config/routes.rb

  # The priority is based upon order of creation: first created -> highest priority.
  map.root :controller => "pages", :action => "home"
  map.connect '/', :controller => "pages", :action => "home"

  map.namespace(:admin) do |admin|
    admin.root :controller => 'dashboard', :action => 'index'
  end

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  #map.connect 'admin/*path', :controller => 'admin/base', :action => 'error_404'
  map.connect '*path', :controller => 'application', :action => 'error_404'

end
