As an anonymous user
I want to be able to create an account
So that I can buy and sell tickets

Background:
  Given I am an anonymous user
#
# Account Creation: Get entry form
#
Scenario: Anonymous user can reach the signup page
   When I go to /signup
   Then I should see a form for /users

#
# Account Creation: Can create an account
#
Scenario: Anonymous user can create and activate an account

  Given there is no user with login "Oona"
   When I go to the signup form
    And I sign up as 'Oona'
   Then My sign up as 'Oona' should be successful
    And I should receive and open an activation email
   When I follow the first link in the email
   Then there should be an active user with login 'Oona'

#
# Account Creation Failure: Account exists
#

Scenario: Anonymous user can not create an account that already exists
  Given an activated user named "Reggie"
   When I sign up as 'Reggie'
   Then my sign up should fail

#
# Account Creation Failure: Not enough inpu
#
Scenario: Anonymous user can not create an account with no login
   When I sign up as ''
   Then my sign up should fail

Scenario: Anonymous user can not create an account with no password
  Given there is no user with login "Oona"
   When I sign up as 'Oona' with password: '', password_confirmation: ''
   Then my sign up should fail

Scenario: Anonymous user can not create an account with no password_confirmation
  Given there is no user with login "Oona"
   When I sign up as 'Oona' with password: 'monkey', password_confirmation: ''
   Then my sign up should fail

Scenario: Anonymous user can not create an account with mismatched password & password_confirmation
  Given there is no user with login "Oona"
   When I sign up as 'Oona' with password: 'monkey', password_confirmation: 'monkeY'
   Then my sign up should fail

Scenario: Anonymous user can not create an account with bad email
  Given there is no user with login "Oona"
   When I sign up as 'Oona' with email: '@a.b.com'
   Then my sign up should fail

#
# Account Creation: Activation token is wrong!
#

Scenario: Anonymous user can't create and activate an account without correct activation code

  Given there is no user with login "Oona"
   When I go to the signup form
    And I sign up as 'Oona'
   Then My sign up as 'Oona' should be successful
    And I should receive and open an activation email
   When I incorrectly copy the first link in the email
   Then there should be an inactive user with login 'Oona'
   When I try to activate with a blank activation code
   Then there should be an inactive user with login 'Oona'