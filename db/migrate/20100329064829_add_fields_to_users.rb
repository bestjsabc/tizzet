class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
      add_column :users, :title, :string, :limit => 5
      add_column :users, :address, :text
      add_column :users, :city, :string, :limit => 30
      add_column :users, :post_code, :integer
      add_column :users, :country, :string, :limit => 50
      add_column :users, :day_phone, :string, :limit => 20
      add_column :users, :home_phone, :string, :limit => 20
      add_column :users, :mobile_phone, :string, :limit => 20
      add_column :users, :referal, :text
      add_column :users, :agreement, :boolean
  end

  def self.down
    remove_column :users, :title
    remove_column :users, :address
    remove_column :users, :city
    remove_column :users, :post_code
    remove_column :users, :country
    remove_column :users, :day_phone
    remove_column :users, :home_phone
    remove_column :users, :mobile_phone
    remove_column :users, :referal
    remove_column :users, :agreement   
  end
end
