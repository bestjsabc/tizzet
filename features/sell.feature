As a disappointed fan who can't get to a concert
I want to regain the money I spent on the tickets
So that I can go to more concerts

Background:
  Given an activated user named "sellie"
    And I am logged in as 'sellie'

#
# Creating a new ticket for sale
#
Scenario: Ticket seller can list a ticket
   When I submit details of a new ticket
   Then the ticket should be listed as for sale
    And I can find the ticket by searching for its host
    And I can find the ticket by searching for its location


# Suggested other fields for sporting events:
#      | Home Team                 | Man. U           |
#      | Visiting Team             | Arsenal          |