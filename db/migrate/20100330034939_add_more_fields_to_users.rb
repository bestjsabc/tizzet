class AddMoreFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :limit => 50
    add_column :users, :last_name, :string, :limit => 50
    add_column :users, :territory_state, :string, :limit => 3
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :territory_state    
  end
end
  