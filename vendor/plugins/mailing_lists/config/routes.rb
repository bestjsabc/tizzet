ActionController::Routing::Routes.draw do |map|
  map.resources :mailing_lists

  map.namespace(:admin) do |admin|
    admin.resources :mailing_lists
  end
end
