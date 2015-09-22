ActionController::Routing::Routes.draw do |map|
  map.resources :banners

  map.namespace(:admin) do |admin|
    admin.resources :banners
  end
end
