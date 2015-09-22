class PaymentNotificationsController < ApplicationController
  
  protect_from_forgery :except => [:create]
  
  def create
    
    PaymentNotification.create!(:params => params, :purchase_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])
    
    @purchase = Purchase.find(params[:invoice])
    unless @purchase.blank?
      if params[:payment_status] == "Completed"
        
        UserMailer.deliver_seller_confirmation(@purchase)
        UserMailer.deliver_buyer_confirmation(@purchase)
        
        #update the product quantity counter
        @product = Product.find(@purchase.product_id)
        @product.quantity_on_hand -= @purchase.quantity
        @product.quantity_sold += @purchase.quantity
        
        if @product.quantity_on_hand == 0
          @product.status = 2 #sold out
        end
        
        @product.save
        
        @purchase.txn_id = params[:txn_id]
        
        @purchase.save
        
      end
    end
      
    render :nothing => true

  end

end
