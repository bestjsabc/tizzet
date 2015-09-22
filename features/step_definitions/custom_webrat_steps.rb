Then /^I should see a form for '(.*)' using (.*)?$/ do |action, method|
  response.should have_selector("form", :action => action, :method => method)
end
Then /^I should see a form for ([^']*)?$/ do |action|
  response.should have_selector("form", :action => action)
end

Then /^I should (not )?see an? (error|notice|warning)( message)?$/ do |not_text, thing_to_see, _|
  warn "Flash messages do not work in this version of webrat (extra webrat steps)"
end
