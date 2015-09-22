require 'digest/sha1'

class User < ActiveRecord::Base
  include UserAasm
  include UserAuth
  include UserRefinery
  
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100
  validates_format_of       :email,    :with => EmailValidation.email_regex, :message => EmailValidation.bad_email_message
  validates_uniqueness_of   :email, :case_sensitive => false

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :plugins, :reset_code, :title, :address, :city, :post_code, :territory_state, :country, :day_phone, :home_phone, :referal, :agreement
  
  def display
    (first_name || '').empty? ? login : first_name
  end

  def billing_details
    "Capture address info here!"
  end
  
  def self.salutation
    ['Mr', 'Mrs', 'Ms', 'Dr', 'Sir']
  end
  
  def self.referal
    ['google', 'street press', 'friend', 'other']
  end
  
  def self.territory_state
    ['VIC', 'NSW', 'QLD', 'NT', 'SA', 'WA', 'ACT', 'TAS']
  end
end
