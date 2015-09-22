class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :ticket_id, :null => false, :default => -1
      t.integer :quantity, :null => false, :default => 1
      t.integer :buyer_id, :null => false, :default => -1
      t.string :buyer_ip_address, :length => 15, :null => false, :default => ''
      t.integer :amount_in_cents, :null => false, :default => 0
      t.string :credit_card_suffix, :length => 4
      t.string :card_first_name, :length => 32
      t.string :card_last_name, :length => 32
      t.datetime :shipped
      t.datetime :contested
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
