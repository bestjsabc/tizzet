ActionController::Routing::Routes.draw do |map|
  map.resources :purchases
  map.received 'purchases/:id/received', :controller => 'purchases', :action => 'received'

  map.thank_you "/thank_you", :controller => 'purchases', :action => 'thank_you'
  map.namespace(:admin) do |admin|
    admin.resources :purchases
    admin.seller_paid 'purchases/:id/seller_paid', :controller => 'purchases', :action => 'seller_paid'
  end
end
