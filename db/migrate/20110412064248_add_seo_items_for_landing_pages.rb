class AddSeoItemsForLandingPages < ActiveRecord::Migration
  def self.up
    add_column :landing_pages, :browser_title, :string
    add_column :landing_pages, :meta_keywords, :string
    add_column :landing_pages, :meta_description, :text
  end

  def self.down
    remove_column :landing_pages, :meta_description
    remove_column :landing_pages, :meta_keywords
    remove_column :landing_pages, :browser_title
  end
end