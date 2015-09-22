
Given /^.*an anonymous user$/ do
  log_out
end

Given /^I am logged in as '(.*)'$/ do |login|
  log_in(login)
end

When /^I log ?in as '(.*)'( and ask to be remembered)?$/ do |login, remember|
  log_in(login, 'remember_me' => (remember == ''))
end

When /^I log ?in as '(.*)' with an incorrect password$/ do |login|
  log_in(login, 'password' => 'the wrong password')
end

When /^I log ?in as '(.*)' with a blank password$/ do |login|
  log_in(login, 'password' => '')
end

Then /^the logged in user should be '(.*)'$/ do |login|
  check_logged_in!(login)
end

Then /^the remember me cookie should (not )?be set$/ do |not_text|
  warn "Can't easily get this info via webrat."
end

Then /^I should be logged (in|out)$/ do |in_or_out|
  check_logged_in!(nil, in_or_out == 'in')
end

Then /^I should not be logged (in|out)$/ do |in_or_out|
  check_logged_in!(nil, in_or_out == 'out')
end

Then /^'(.*)' should be logged (in|out)$/ do |login, in_or_out|
  check_logged_in!(login, in_or_out == 'in')
end

Then /^'(.*)' should not be logged (in|out)$/ do |login, in_or_out|
  check_logged_in!(login, in_or_out == 'out')
end

Then /^my login should have failed$/ do
  Then %{I should see an error message}
   And %{I should not be logged in}
   And %{the remember me cookie should not be set}
end

module SessionHelpers

  def check_logged_in!(login, logged_in=true)
    str = login ? "Welcome, #{login}" : "Welcome,"
    if logged_in
      response.should contain(str)
    else
      response.should_not contain(str)
    end
  end

  def log_out
    delete '/session'
  end

  def log_in(login, opts={})
    visit('/')
    password = opts['password'] || named_user_details(login)['password']
    fill_in('session[login]', :with => login)
    fill_in('session[password]', :with => password)
    fill_in('session[remember_me]', :with => 1) if opts['remember_me']
    And %{I press ""}
  end
  
end
World(SessionHelpers)

