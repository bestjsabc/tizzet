ActionController::Routing::Routes.draw do |map|
  map.resource :member_session
  map.resources :members
  map.resources :password_resets
  
  map.namespace(:admin) do |admin|
    admin.resources :members
  end
end
