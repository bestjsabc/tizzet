class RenameImageToFilenameLandingPages < ActiveRecord::Migration
  def self.up
    
    rename_column :landing_pages, :image, :filename
    
  end

  def self.down
    
    rename_column :landing_pages, :filename, :image
    
  end
end
