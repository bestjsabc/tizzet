class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :event_type, :limit => 10, :null => false
      t.string :host, :limit => 30, :default => '', :null => false
      t.string :visitor, :limit => 30, :default => '', :null => false
      t.string :event, :limit => 30, :default => '', :null => false
      t.string :seating_type, :limit => 11, :default => 'Unallocated', :null => false
      t.boolean :individual_sales, :default => true, :null => false
      t.date :date, :null => false
      t.string :location, :limit => 60, :default => '', :null => false
      t.string :state, :limit => 10, :default => 'Available', :null => false
      t.integer :seller_id, :null => false, :default => -1
      t.integer :buyer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
