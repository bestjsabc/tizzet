class RemoveSalutationFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :salutation
  end

  def self.down
    add_column :users, :salutation, :string
  end
end
