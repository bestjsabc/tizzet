class Admin::BannersController < Admin::BaseController

  crudify :banner, :title_attribute => :product_id, :order => "created_at DESC", :conditions => "parent_id is NULL", :sortable => false

end
