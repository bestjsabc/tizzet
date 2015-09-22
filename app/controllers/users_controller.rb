class UsersController < ApplicationController
  layout 'application'
  filter_parameter_logging 'password', 'password_confirmation'
  
  before_filter :load_arrays

  def show
    id = params[:id] || (current_user and current_user.id)
    if id
      @user = User.find(id)
    else
      redirect_to :action => :new 
      return
    end
  end
  
  def new
    
    @user = User.new(params[:user])
    
  end

  def create
    cookies.delete :auth_token
    self.current_user = nil
    @user = User.new(params[:user])
    @user.register! if @user.valid?
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Welcome to Tizzet, #{current_user.login}."
    else
      flash[:error]  = "There was an issue setting up your account, sorry.  Please try again, or contact admin@tizzet.com"
      render :action => 'new'
    end
  end

  def activate
    self.current_user = nil
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      self.current_user = user
      flash[:notice] = "Your account has been activated."
      redirect_to '/'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def forgot
    if request.post?
      if (user = User.find_by_email(params[:user][:email])).present?
        user.create_reset_code

        begin
          flash[:notice] = "An email has been sent to #{user.email} with a link to reset your password."
          UserMailer.deliver_reset_notification(user, request)
        rescue
          logger.info "Error: email could not be sent for user password reset for user #{user.id} with email #{user.email}"
        end
      else
        flash[:notice] = "Sorry, #{params[:user][:email]} isn't associated with any accounts. Are you sure you typed the correct email address?"
      end

      redirect_back_or_default(forgot_url)
    end
  end

  def reset
    @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?

    if request.post?
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        self.current_user = @user
        @user.delete_reset_code

        flash[:notice] = "Password reset successfully for #{@user.email}"
        redirect_back_or_default(admin_root_url)
      else
        render :action => :reset
      end
    end
  end
  
private
  
  def load_arrays
    @salutation = User.salutation
    @referal = User.referal
    @state = User.territory_state
  end

end
