class Ticket < ActiveRecord::Base
  
  belongs_to :seller, :class_name => 'User'
  validates_numericality_of :quantity, :price_in_cents
  validates_presence_of :quantity, :price_in_cents
  has_many :orders
  
  def self.event_types
    [ 'Concert', 'Sport', 'Arts and Theatre' ]
  end
  def self.seating_types
    [ 'General Admission', 'Seated']
  end

  def price
    price_in_cents.to_f / 100
  end
  
  def price=(val)
    self.price_in_cents = (val * 100).to_i
  end
  
  
  def allowed_purchase_quantites
    (1..quantity).to_a
  end
end
