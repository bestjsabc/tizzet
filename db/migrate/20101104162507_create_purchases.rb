class CreatePurchases < ActiveRecord::Migration

  def self.up
    create_table :purchases do |t|
      t.integer :product_id
      t.integer :member_id
      t.integer :quantity
      t.float :price
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :post_code
      t.string :country
      t.string :day_phone
      t.string :home_phone
      t.string :mobile_phone
      t.string :card_first_name
      t.string :card_last_name
      t.string :card_type
      t.string :credit_card_number
      t.integer :expiry_month
      t.integer :expiry_year
      t.integer :verification_code
      t.integer :position

      t.timestamps
    end

    add_index :purchases, :id

    User.find(:all).each do |user|
      user.plugins.create(:title => "Purchases", :position => (user.plugins.maximum(:position) || -1) +1)
    end

    page = Page.create(
      :title => "Purchases",
      :link_url => "/purchases",
      :deletable => false,
      :position => ((Page.maximum(:position, :conditions => "parent_id IS NULL") || -1)+1),
      :menu_match => "^/purchases(\/|\/.+?|)$"
    )
    RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end

  def self.down
    UserPlugin.destroy_all({:title => "Purchases"})

    Page.find_all_by_link_url("/purchases").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/purchases"})

    drop_table :purchases
  end

end
