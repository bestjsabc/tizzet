As an anonymous user with an account
I want to log in to my account
So that I can see my stuff

Background:
  Given an anonymous user
#
# Log in: get form
#
Scenario: Anonymous user can get a login form.
   When I go to the home page
   Then I should see a form for '/session' using post

#
# Log in successfully, but don't remember me
#

Scenario: Logged-in user who logs in should be the new one
  Given an activated user named "reggie"
    And an activated user named "oona"
    And I am logged in as 'oona'
   When I login as 'reggie'
   Then I should be logged in
    And the logged in user should be 'reggie'
    And the remember me cookie should not be set

#
# Log in successfully, remember me
#

Scenario: Logged-in user who logs in should be the new one
  Given an activated user named "reggie"
   When I login as 'reggie' and ask to be remembered
   Then I should be logged in
    And the remember me cookie should be set
 
#
# Log in unsuccessfully
#

Scenario: Logged-in user who fails logs in should be logged out
  Given an activated user named "oona"
    And I am logged in as 'oona'
   When I log in as 'reggie' with an incorrect password
   Then my login should have failed

Scenario: Log-in with bogus info should fail
  Given an activated user named "reggie"
   When I log in as 'reggie' with an incorrect password
   Then my login should have failed

   When I log in as 'reggie' with a blank password
   Then my login should have failed

   When I log in as ''
   Then my login should have failed

   When I log in as 'leonard_shelby'
   Then my login should have failed

#
# Log out successfully (should always succeed)
#

Scenario: Anonymous (logged out) user can log out.
   When I go to /logout
   Then I should be logged out
    And I should not see an error
    And I should see a notice

Scenario: Logged in user can log out.
  Given an activated user named "oona"
    And I am logged in as 'oona'
  When  I go to /logout
   Then I should be logged out
    And I should not see an error
    And I should see a notice