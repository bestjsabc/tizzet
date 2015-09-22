ActionController::Routing::Routes.draw do |map|
  map.resources :products

  map.namespace(:admin) do |admin|
    admin.resources :products
  end
end
