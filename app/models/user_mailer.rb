class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://www.tizzet.com.au/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://www.tizzet.com.au/"
  end

  def reset_notification(user, request)
    setup_email(user)
    @subject    += 'Link to reset your password'
    @body[:url]  = "#{request.protocol}#{request.host_with_port}/reset/#{user.reset_code}"
  end
  
  def mailing_list_thankyou(subscriber)
    setup_email(subscriber)
    @subject    += 'Thank you for Joining our Mailing List'
    @body[:url]  = "http://www.tizzet.com.au/"
  end
  
  def signup_thankyou(member)
    @member = member
    setup_email(member)
    @subject    += 'Thank you for Signing-Up on Tizzet'
    @body[:url]  = "http://www.tizzet.com.au/"
  end
  
  def seller_confirmation(purchase)
    @seller = Member.find(purchase.seller_id)
    setup_email(@seller)
    @subject += 'Purchase Confirmation Of Your Listed Ticket'
    body :purchase => purchase
    content_type "text/html"
  end
  
  def buyer_confirmation(purchase)
    @buyer = Member.find(purchase.buyer_id)
    setup_email(@buyer)
    @subject += 'Your Tizzet Ticket Purchase'
    body :purchase => purchase
    content_type "text/html"
  end

protected
  def setup_email(user)
    @recipients  = user.email
    @from        = "noreply@tizzet.com.au"
    @subject     = "[www.tizzet.com.au] "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
