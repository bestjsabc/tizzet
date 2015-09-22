class AddPositionToLandingPage < ActiveRecord::Migration
  def self.up
    
    add_column :landing_pages, :position, :integer
    
  end

  def self.down
    
    remove_column :landing_pages, :position
    
  end
end
