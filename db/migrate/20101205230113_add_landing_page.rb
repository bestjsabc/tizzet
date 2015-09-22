class AddLandingPage < ActiveRecord::Migration
  def self.up
    
    create_table :landing_pages do |t|
      
      t.string :title
      t.text :description
      t.string :image
      
    end
    
    User.find(:all).each do |user|
      user.plugins.create(:title => "Landing Pages", :position => (user.plugins.maximum(:position) || -1) +1)
    end
    
    page = Page.create(
      :title => "Landing Page",
      :link_url => "/landing_pages",
      :deletable => false,
      :position => ((Page.maximum(:position, :conditions => "parent_id IS NULL") || -1)+1),
      :menu_match => "^/landing_pages(\/|\/.+?|)$"
    )
    RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
    
  end

  def self.down
    
    UserPlugin.destroy_all({:title => "Landing Pages"})

    Page.find_all_by_link_url("/landing_pages").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/landing_pages"})
    
    drop_table :landing_pages
    
  end
end
