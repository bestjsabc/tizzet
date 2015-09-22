class AddTerritoryStateToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :territory_state, :string
  end

  def self.down
    remove_column :ticket, :territory_state
  end
end
