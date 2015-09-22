class CreateMembers < ActiveRecord::Migration

  def self.up
    create_table :members do |t|
      t.string :login
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :single_access_token
      t.string :perishable_token
      t.string :activation_code
      t.datetime :activated_at
      t.string :title
      t.text :address
      t.string :city
      t.integer :post_code
      t.string :country
      t.string :day_phone
      t.string :home_phone
      t.string :mobile_phone
      t.text :referal
      t.boolean :agreement
      t.string :first_name
      t.string :last_name
      t.string :territory_state
      t.integer :position

      t.timestamps
    end

    add_index :members, :id

    User.find(:all).each do |user|
      user.plugins.create(:title => "Members", :position => (user.plugins.maximum(:position) || -1) +1)
    end

    page = Page.create(
      :title => "Members",
      :link_url => "/members",
      :deletable => false,
      :position => ((Page.maximum(:position, :conditions => "parent_id IS NULL") || -1)+1),
      :menu_match => "^/members(\/|\/.+?|)$"
    )
    RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end

  def self.down
    UserPlugin.destroy_all({:title => "Members"})

    Page.find_all_by_link_url("/members").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/members"})

    drop_table :members
  end

end
