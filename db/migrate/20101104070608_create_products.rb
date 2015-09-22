class CreateProducts < ActiveRecord::Migration

  def self.up
    create_table :products do |t|
      t.string :event_type
      t.string :host
      t.string :visitor
      t.string :event
      t.string :seating_type
      t.boolean :individual_seats
      t.date :date
      t.string :location
      t.string :state
      t.integer :seller_id
      t.integer :quantity
      t.string :territory_state
      t.integer :position

      t.timestamps
    end

    add_index :products, :id

    User.find(:all).each do |user|
      user.plugins.create(:title => "Products", :position => (user.plugins.maximum(:position) || -1) +1)
    end

    page = Page.create(
      :title => "Products",
      :link_url => "/products",
      :deletable => false,
      :position => ((Page.maximum(:position, :conditions => "parent_id IS NULL") || -1)+1),
      :menu_match => "^/products(\/|\/.+?|)$"
    )
    RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end

  def self.down
    UserPlugin.destroy_all({:title => "Products"})

    Page.find_all_by_link_url("/products").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/products"})

    drop_table :products
  end

end
