class AddImageFieldsToLandingPages < ActiveRecord::Migration
  def self.up
    
    add_column :landing_pages, :thumbnail, :string
    add_column :landing_pages, :size, :integer
    add_column :landing_pages, :width, :integer
    add_column :landing_pages, :height, :integer
    add_column :landing_pages, :image_type, :integer
    add_column :landing_pages, :content_type, :string
    add_column :landing_pages, :parent_id, :integer
    
  end

  def self.down
    
    remove_column :landing_pages, :thumbnail
    remove_column :landing_pages, :size
    remove_column :landing_pages, :width
    remove_column :landing_pages, :height
    remove_column :landing_pages, :image_type
    remove_column :landing_pages, :content_type
    remove_column :landing_pages, :parent_id
    
  end
end
