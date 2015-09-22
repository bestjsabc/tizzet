class RemoveLoginFieldFromMembers < ActiveRecord::Migration
  def self.up
    
    remove_column :members, :login
    
  end

  def self.down
    
    add_column :members, :login, :string
    
  end
end
