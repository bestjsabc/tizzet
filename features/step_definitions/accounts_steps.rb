Given /^there is no user with login "([^\"]*)"$/ do |login|
  User.delete_all ['login = ?', login]
end

Given /^an activated user named "([^\"]*)"$/ do |login|
  Given %{there is no user with login "#{login}"}
   When %{I go to the signup form}
    And %{I sign up as '#{login}'}
   Then %{My sign up as '#{login}' should be successful}
    And %{I should receive and open an activation email}
   When %{I follow the first link in the email}
   Then %{there should be an active user with login '#{login}'}
end

When /^I sign up as '([^']*)'$/ do |login|
  signup(login)
end

When /^I sign up as '([^']*)' with email: '([^']*)'$/ do |login, email|
  signup(login) do
    fill_in 'user[email]', :with => email
  end
end

When /^I sign up as '([^']*)' with password: '([^']*)', password_confirmation: '([^']*)'$/ do |login, pw, pw_conf|
  signup(login) do
    fill_in 'user[password]', :with => pw
    fill_in 'user[password_confirmation]', :with => pw_conf
  end
end

When /^I incorrectly copy the first link in the email$/ do
  visit(first_link_in_email + 'asdf')
end

When /^I try to activate with a blank activation code$/ do
  visit(activate_url(''))
end

Then %{I should receive and open an activation email} do
  Then %{I should receive an email}
  When %{I open the email}
end

Then /^My sign up as '(.*)' (should be) successful$/ do |login, _|
  Then %{there should be an inactive user with login '#{login}'}
  Then %{'#{login}' should be logged in}
end

Then /^my sign up should fail$/ do
  Then %{I should see an error message}
   And %{I should not be logged in}
end

Then /^there should be an active user with login '(.*)'$/ do |login|
  check_user_active(login, true)
end

Then /^there should be an inactive user with login '(.*)'$/ do |login|
  check_user_active(login, false)
end

module AccountsHelpers
  def check_user_active(login, state)
    u = User.find_by_login(login.downcase)
    u.active?.should == state
  end

  def named_user( cased_login )
    login = cased_login.downcase
    @named_users ||= {}
    if !@named_users[login] 
      @named_users[login] = User.make_unsaved(:login => login, :name => cased_login)
    end
    @named_users[login]
  end

  def named_user_details( login )
    {
      'login' => named_user(login).login,
      'email' => named_user(login).email,
      'name' => named_user(login).name,
      'password' => named_user(login).password,
      'password_confirmation' => named_user(login).password
    }
  end

  def enter_user_details(login)
    named_user_details(login).each do |field, value|
      fill_in("user[#{field}]", :with => value)
    end
  end
  
  def signup(login)
    visit('/signup')
    enter_user_details(login)
    yield if block_given?
    And %{I press "Sign up"}
    self.last_email_address = named_user(login).email
  end
end
World(AccountsHelpers)