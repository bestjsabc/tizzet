class RemoveBuyerFromTickets < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :buyer_id
  end

  def self.down
    add_column :tickets, :buyer_id, :integer
  end
end
