class Purchase < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :first_name, :last_name, :address, :city, :post_code, :country, :day_phone, :home_phone, :mobile_phone, :card_first_name, :card_last_name, :card_type, :credit_card_number],
                  :index_file => [Rails.root.to_s, "tmp", "index"]

  validates_presence_of :quantity, :message => "can't be blank"
  validates_numericality_of :quantity, :message => "is not a number"
  #validates_presence_of :card_first_name, :on => :create, :message => "can't be blank"
  #validates_presence_of :card_last_name, :on => :create, :message => "can't be blank"
  #validates_presence_of :card_type, :on => :create, :message => "can't be blank"
  #validates_presence_of :credit_card_number, :on => :create, :message => "can't be blank"
  #validates_presence_of :verification_code, :on => :create, :message => "can't be blank"
  #validates_presence_of :expiry_month, :on => :create, :message => "can't be blank"
  #validates_presence_of :expiry_year, :on => :create, :message => "can't be blank"
  validates_presence_of :product_id, :on => :create, :message => "can't be blank"
  validates_presence_of :first_name, :on => :create, :message => "can't be blank"
  validates_presence_of :last_name, :on => :create, :message => "can't be blank"
  validates_presence_of :address, :on => :create, :message => "can't be blank"
  validates_presence_of :city, :on => :create, :message => "can't be blank"
  validates_presence_of :post_code, :on => :create, :message => "can't be blank"
  validates_presence_of :country, :on => :create, :message => "can't be blank"

  belongs_to :member
  belongs_to :product
  
  def ticket_seller
    
    Member.find(self.product.seller_id)
    
  end
  
  def buyer_fee
    
   return (self.price * self.quantity / 100) * APP_CONFIG['buyer_fee_percentage']
    
  end
  
  def seller_fee(quantity)
    
    return ((self.price * quantity) / 100) * APP_CONFIG['seller_fee_percentage']
    
  end
  
  def total_with_buyer_fee
    
    return (self.price * self.quantity) + self.buyer_fee
    
  end
  
  def total_with_seller_fee
    
    return (self.price * self.quantity) + self.seller_fee(self.quantity)
    
  end
  
  def seller_will_receive
    
    return (self.price * self.quantity) - self.seller_fee(self.quantity)
    
  end
  
  def single_with_buyer_fee
    
    buyer_fee = (self.price / 100) * APP_CONFIG['buyer_fee_percentage']
    
    return self.price + buyer_fee
    
  end
  
  def fullname
    "#{self.first_name} #{self.last_name}"
  end

  def fulladdress
    "#{self.address} #{self.city} #{self.post_code} #{self.country}"
  end

  def paypal_encrypted(return_url)    
	 values = {
	   :business =>  "paul@tizzet.com.au", # rkjbs_1291674029_biz@webfirm.com
	   :cmd => '_cart',
	   :upload => 1,
	   :return => "http://www.tizzet.webfirmdemo.com#{return_url}", #"http://www.tizzet.com.au#{return_url}",
	   :invoice => self.id,
	   :currency_code => "AUD",
	   :cert_id => "XEZBFLNXRKUA4" #W2Q7H2QBJ6LQS BZGDJ526HUXEL, X5CDTMCEDK3BG, V5VGU44WS2D9A
	 }
	 values.merge!({
      "amount_1" => self.single_with_buyer_fee,
      "item_name_1" => self.product.event,
      "item_number_1" => self.product.id,
      "quantity_1" => self.quantity
    })

   encrypt_for_paypal(values)
	end

	PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM    = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM     = File.read("#{Rails.root}/certs/app_key.pem")

  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
end
