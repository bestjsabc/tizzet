When /^I submit details of a new ticket$/ do
  visit('/tickets/new')
  @ticket = Ticket.make_unsaved()
  ["date", "location", "host", "visitor", "event", "quantity"].each do |field|
    fill_in("ticket[#{field}]", :with => @ticket.send(field))
  end
  choose("ticket_event_type_#{@ticket.event_type.downcase.gsub(" ", "_")}")
  select @ticket.seating_type, :from => "ticket[seating_type]"
  fill_in("ticket[price]", :with => @ticket.price.to_s)
  if @ticket.individual_sales
    check("ticket[individual_sales]")
  else
    uncheck("ticket[individual_sales]")
  end
  click_button "Sell ticket"
end

Then /^the ticket should be listed as for sale$/ do
  @ticket = Ticket.find :first, :conditions => match_on_fields(ticket_ident_fields, @ticket)
  @ticket.should_not be_nil
  Ticket.find(@ticket.id).state.should == "Available"
end

Then /^I can find the ticket by searching for its host$/ do
  visit("/search/#{CGI.escape(@ticket.host)}")
  within SEARCH_RESULT_CLASS do |scope|
    scope.should contain(@ticket.location)
  end
  should_contain_ticket_search_result(@ticket)
end

Then /^I can find the ticket by searching for its location$/ do
  visit("/search/#{CGI.escape(@ticket.location)}")
  should_contain_ticket_search_result(@ticket)
end

module SellHelpers
  def should_contain_ticket_search_result(ticket)
    within SEARCH_RESULT_CLASS do |scope|
      scope.should contain_somewhere(ticket.location)
      scope.should contain_somewhere(ticket.host)
      scope.should contain_somewhere(ticket.id)
    end
  end

  def contain_somewhere(string)
    contain(Regexp.new('.*' + string.to_s + '.*'))
  end
  
  def ticket_ident_fields
    ["date", "location", "host", "visitor", "event", "event_type", "seating_type", "individual_sales", "quantity"]
  end
  
  def match_on_fields(fields, ticket)
    fields.map { |field| ticket.send( field ) }.unshift( fields.map { |field| "#{field} = ?" }.join( " and " ) )
  end
  
end
World(SellHelpers)