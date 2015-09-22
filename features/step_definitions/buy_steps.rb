class Order
  def self.credit_card_types_for_select
    [["Bogus", "bogus"], ["MasterCard", "master"], ["Discover", "discover"], ["American Express", "american_express"]]
  end
end

Given /^"([^\"]*)" has listed "([^\"]*)" adjacent tickets to a "([^\"]*)" hosted by "([^\"]*)" on "([^\"]*)" for \$"([^\"]*)"$/ do |seller, qty, type, host, date, price|
  @ticket = Ticket.make(
    :quantity => qty,
    :seller_id => User.find_by_login(seller).id,
    :date => Date.strptime(date, '%d/%M/%Y'),
    :event => "#{host}'s #{type}",
    :host => host,
    :event_type => type,
    :state => 'Available',
    :individual_sales => true,
    :price_in_cents => (price.to_f * 100).to_i
  )
  
#    t.string   "visitor",          :limit => 30, :default => "",            :null => false
#    t.string   "event",            :limit => 30, :default => "",            :null => false
#    t.string   "seating_type",     :limit => 11, :default => "Unallocated", :null => false
#    t.boolean  "individual_sales",               :default => true,          :null => false
#    t.string   "location",         :limit => 60, :default => "",            :null => false
end

When /^I search for "([^\"]*)"$/ do |query|
  visit "/search/#{query}"
end

When /^I select the first search result$/ do
  within SEARCH_RESULT_CLASS do |scope|
    scope.click_link "Buy"
  end
end

When /^I enter my order details for (\d+) tickets$/ do |number|
  fill_in "order[quantity]", :with => number.to_i
  fill_in "order[card_number]", :with => '1' # 5476984513212000
  fill_in "order[card_verification]", :with => '365'
  fill_in "order[card_first_name]", :with => Faker::Name.first_name
  fill_in "order[card_last_name]", :with => Faker::Name.last_name
  fill_in "order[card_month]", :with => 11
  fill_in "order[card_year]", :with => 2011
  select "Bogus"
end

When /^I submit the form$/ do
  click_button "Buy"
end

When /^I mark the ticket as sent$/ do
  fill_in 'order[tracking_number]', :with => '12345'
  click_button 'Ship Order'
end

Then /^I should see an order that has( not)? been sent$/ do |negator|
  response.should have_selector("li.order.#{negator.nil? ? 'sent' : 'unsent'}")
end

Then /^I should see a sale order against the ticket$/ do
  within "li.ticket" do |scope|
    scope.should have_selector("li.order")
  end
end


