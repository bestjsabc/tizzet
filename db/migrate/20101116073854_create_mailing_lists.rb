class CreateMailingLists < ActiveRecord::Migration

  def self.up
    create_table :mailing_lists do |t|
      t.string :name
      t.string :email
      t.integer :position

      t.timestamps
    end

    add_index :mailing_lists, :id

    User.find(:all).each do |user|
      user.plugins.create(:title => "Mailing Lists", :position => (user.plugins.maximum(:position) || -1) +1)
    end

    page = Page.create(
      :title => "Mailing Lists",
      :link_url => "/mailing_lists",
      :deletable => false,
      :position => ((Page.maximum(:position, :conditions => "parent_id IS NULL") || -1)+1),
      :menu_match => "^/mailing_lists(\/|\/.+?|)$"
    )
    RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
      page.parts.create(:title => default_page_part, :body => nil)
    end
  end

  def self.down
    UserPlugin.destroy_all({:title => "Mailing Lists"})

    Page.find_all_by_link_url("/mailing_lists").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/mailing_lists"})

    drop_table :mailing_lists
  end

end
