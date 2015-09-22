class MakeEventTypeWider < ActiveRecord::Migration
  def self.up
    change_column :tickets, :event_type, :string, :limit => 16
  end

  def self.down
    change_column :tickets, :event_type, :string, :limit => 10
  end
end
