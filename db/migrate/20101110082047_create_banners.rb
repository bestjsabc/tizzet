class CreateBanners < ActiveRecord::Migration

  def self.up
    create_table :banners do |t|
      t.integer :product_id
      t.integer :parent_id
      t.string :content_type
      t.string :filename
      t.string :thumbnail
      t.integer :size
      t.integer :width
      t.integer :height
      t.string :image_type
      t.boolean :archived
      t.integer :position

      t.timestamps
    end

    add_index :banners, :id

    User.find(:all).each do |user|
      user.plugins.create(:title => "Banners", :position => (user.plugins.maximum(:position) || -1) +1)
    end

    page = Page.create(
      :title => "Banners",
      :link_url => "/banners",
      :deletable => false,
      :position => ((Page.maximum(:position, :conditions => "parent_id IS NULL") || -1)+1),
      :menu_match => "^/banners(\/|\/.+?|)$"
    )
    RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end

  def self.down
    UserPlugin.destroy_all({:title => "Banners"})

    Page.find_all_by_link_url("/banners").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/banners"})

    drop_table :banners
  end

end
