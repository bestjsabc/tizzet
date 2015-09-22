ActionController::Routing::Routes.draw do |map|
  map.resources :landing_pages
  
  map.events 'events/:id/:title', :controller => 'landing_pages', :action => 'show'

  map.namespace(:admin) do |admin|
    admin.resources :landing_pages
  end
end
