As an avid concert-goer
I want to find and buy tickets through tizzet
So that I can go to more concerts

Background:
  Given an activated user named "buyer"
  Given an activated user named "seller"
	And "seller" has listed "3" adjacent tickets to a "concert" hosted by "Pink" on "16/07/2010" for $"100"
#	And "seller" has listed "3" non adjacent tickets to a "game" hosted by "Carlton F.C." against "Collingwood F.C" on "19/07/2010"
#	And "seller" has listed "1" non adjacent ticket to a "show" called "Tickled Pink" on "19/08/2010"

Scenario: Purchase a ticket
  Given I am logged in as 'buyer'
   Then the logged in user should be 'buyer'
   When I search for "Pink"
    And I select the first search result
    And I enter my order details for 2 tickets
    And I submit the form
   Then I should see "Tickets Bought successfully"
   When I go to /orders
   Then I should see an order that has not been sent
  Given I am logged in as 'seller'
   When I go to /tickets
   Then I should see a sale order against the ticket
   When I mark the ticket as sent
  Given I am logged in as 'buyer'
   When I go to /orders
   Then I should see an order that has been sent
