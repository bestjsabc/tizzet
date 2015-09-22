# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.

class ApplicationController < Refinery::ApplicationController
  before_filter :load_menu_settings, :load_dynamic_sections
  helper :all
  helper_method :current_member_session, :current_member
  filter_parameter_logging :password, :password_confirmation
  
private
  def load_menu_settings
    @menu_hide_children = RefinerySetting.find_or_set(:menu_hide_children, false)
  end
  
  def load_dynamic_sections
    @featured_searches = []
    @latest_tickets = Product.available.find(:all, :order => 'created_at DESC', :limit => 7)    
    @featured_tickets = Product.available.find(:all, :order => 'created_at DESC', :limit => 3)
    @hot_tickets = Product.available.hot_picks.all
    @landing_pages = LandingPage.all.select{|p| p.parent_id.nil?}
  end
  
  def require_login
    redirect_to :controller => :sessions, :action => :new unless logged_in?
  end
  
  def current_member_session
    return @current_member_session if defined?(@current_member_session)
    @current_member_session = MemberSession.find
  end

  def current_member
    return @current_member if defined?(@current_member)
    @current_member = current_member_session && current_member_session.record
  end

  def require_member
    unless current_member
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_member_session_url
      return false
    end
  end

  def require_no_member
    if current_member
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to url_for(current_member)
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
