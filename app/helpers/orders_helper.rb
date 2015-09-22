module OrdersHelper
  def self.credit_card_types_for_select
    [["Visa", "visa"], ["MasterCard", "master"], ["Discover", "discover"], ["American Express", "american_express"]]
  end
end
