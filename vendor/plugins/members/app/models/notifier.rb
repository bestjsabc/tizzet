class Notifier < ActionMailer::Base  
  default_url_options[:host] = "www.tizzet.com.au"  
  
  def password_reset_instructions(member)  
    subject       "Password Reset Instructions"  
    from          member.email 
    recipients    member.email  
    sent_on       Time.now  
    body          :edit_password_reset_url => edit_password_reset_url(member.perishable_token)  
  end  
end