class PaymentNotification < ActiveRecord::Base
  
  belongs_to :purchase
  serialize :params
  
  after_create :mark_purchase_as_purchased
  
  def mark_purchase_as_purchased
    
    if self.status == "Completed"
      
      self.purchase.update_attributes(:payment_status => 2)
      
    end
    
  end
  
end
