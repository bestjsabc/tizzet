class Member < ActiveRecord::Base
  
  acts_as_indexed :fields => [:email, :crypted_password, :password_salt, :persistence_token, :single_access_token, :perishable_token, :activation_code, :title, :address, :city, :country, :day_phone, :home_phone, :mobile_phone, :referal, :first_name, :last_name, :territory_state],
                  :index_file => [Rails.root.to_s, "tmp", "index"]
                  
  acts_as_authentic
  
  #validates_presence_of :login
  #validates_uniqueness_of :login
  
  has_many :products, :class_name => "Product", :foreign_key => "seller_id"
  has_many :purchases

  def display
    (first_name || '').empty? ? email : first_name
  end
  
  def fullname
    "#{first_name.upcase} #{last_name.upcase}"
  end

  def billing_details
    "Capture address info here!"
  end
  
  def self.salutation
    ['Mr', 'Mrs', 'Ms', 'Dr', 'Sir']
  end
  
  def self.referal
    ['facebook', 'google', 'street press', 'friend', 'other']
  end
  
  def self.territory_state
    ['VIC', 'NSW', 'QLD', 'NT', 'SA', 'WA', 'ACT', 'TAS']
  end
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end

end
