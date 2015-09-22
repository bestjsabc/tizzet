class Admin::PurchasesController < Admin::BaseController

  crudify :purchase, :title_attribute => :product_id, :order => 'created_at DESC'
  
  def seller_paid
    
    @purchase = Purchase.find(params[:id])
    @purchase.seller_paid = true
    @purchase.save
    
    redirect_to edit_admin_purchase_path(@purchase)
    
  end

end
