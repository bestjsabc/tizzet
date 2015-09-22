class SessionsController < ApplicationController

  filter_parameter_logging 'password', 'password_confirmation'

  def create
    email = params[:session] && params[:session][:login]
    password = params[:session] && params[:session][:password]
    
    self.current_user = User.authenticate(email, password)
    if logged_in?
      if (params[:session] and (params[:session][:remember_me] == "1"))
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = {:value => self.current_user.remember_token ,
                                :expires => self.current_user.remember_token_expires_at}
      end
      if current_user.superuser
        redirect_back_or_default(admin_root_url)
      else
        redirect_back_or_default('/')
      end
      flash[:notice] = "Logged in successfully"
    else
      flash.now[:error] = "Sorry, your password or username was incorrect."
      note_failed_signin
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(new_session_url)
  end

protected

  # Prevent the login page being taken down as it's needed to bring the site up again.
  def take_down_for_maintenance?;end

  # Track failed login attempts
  def note_failed_signin
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
  
end
