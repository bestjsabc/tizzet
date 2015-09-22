class Order < ActiveRecord::Base

  belongs_to :buyer, :foreign_key => :buyer_id, :class_name => 'User'
  belongs_to :ticket
  has_many :transactions, :class_name => "OrderTransaction"

  attr_accessor :card_number, :card_verification, :card_month, :card_year, :card_type

#  validate_on_create :validate_card

  def purchase!
    success = false
  #  return false if !valid?
    transaction do
      lock!
      ticket.lock!
      raise "You must purchase all the tickets in this listing together." unless ticket.individual_sales or (self.quantity == ticket.quantity)
      self.amount_in_cents = ticket.price_in_cents * self.quantity
      ticket.quantity -= self.quantity
      save!
      ticket.save!
#      response = GATEWAY.purchase(amount_in_cents, credit_card, purchase_options)
 #     transactions.create!(:action => "purchase", :amount => amount_in_cents, :response => response)
  #    success = response.success?
      success = true
    end
    success
  end
  
  def self.credit_card_types_for_select
    [["Visa", "visa"], ["MasterCard", "master"], ["Discover", "discover"], ["American Express", "american_express"]]
  end
  
  private
  
  def purchase_options
    {
      :ip => buyer_ip_address,
      :billing_address => self.buyer.billing_details
    }
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end
  
  def credit_card
    date = Date.civil(card_year.to_i, card_month.to_i, 1)
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => date.month,
      :year               => date.year,
      :first_name         => card_first_name,
      :last_name          => card_last_name
    )
  end
end
