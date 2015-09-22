class Product < ActiveRecord::Base

  acts_as_indexed :fields => [:event_type, :host, :visitor, :event, :seating_type, :location, :state, :territory_state],
                  :index_file => [Rails.root.to_s, "tmp", "index"]

  belongs_to :member, :class_name => "Member", :foreign_key => "seller_id"
  
  validates_numericality_of :quantity, :price
  validates_presence_of :quantity, :price
  
  has_many :purchases, :dependent => :destroy
  has_many :banners
  
  before_update :sync_quantities
  
  named_scope :hot_picks, :conditions => ["hot_ticket_pick = ?", true]
  
  named_scope :available, :conditions => ["list_until >= ? AND status = 1", Date.today]
  
  def self.event_types
    [ 'Concert', 'Sport', 'Arts and Theatre' ]
  end
  
  def self.seating_types
    [ 'General Admission', 'Seated']
  end
  
  def self.ticket_status
    {'Active' => 1, 'Sold Out' => 2, 'Cancelled' => 3, 'Expired' => 4}
  end
  
  def allowed_purchase_quantites
    (1..quantity - quantity_sold).to_a
  end
  
  def seller_fee(quantity)
    
    return ((self.price * quantity) / 100) * APP_CONFIG['seller_fee_percentage']
    
  end
  
  private
    def sync_quantities
      self.quantity_on_hand = self.quantity if self.quantity_sold == 0
      #self.status = 2 if self.quantity_on_hand == 0
    end

end
