class Admin::ProductsController < Admin::BaseController

  crudify :product, :title_attribute => :event_type, :order => 'created_at DESC'

end
