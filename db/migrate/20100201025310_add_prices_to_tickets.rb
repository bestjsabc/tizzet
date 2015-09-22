class AddPricesToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :price_in_cents, :integer
  end

  def self.down
    remove_column :tickets, :price_in_cents
  end
end
