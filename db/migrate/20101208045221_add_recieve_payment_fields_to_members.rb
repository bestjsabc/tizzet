class AddRecievePaymentFieldsToMembers < ActiveRecord::Migration
  
  def self.up
  
    add_column :members, :aus_bank_num, :integer
    add_column :members, :bsb_num, :integer
    add_column :members, :bank, :string
    add_column :members, :paypal_account, :string
    add_column :members, :paypal_email, :string
  
  end

  def self.down
    
    remove_column :members, :aus_bank_num
    remove_column :members, :bsb_num
    remove_column :members, :bank
    remove_column :members, :paypal_account
    remove_column :members, :paypal_email
    
  end
  
end
