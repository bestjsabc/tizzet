class Admin::UsersController < Admin::BaseController

  crudify :user, :order => 'email', :title_attribute => 'email', :conditions => "state = 'active'"

  # Protect these actions behind an admin login
  before_filter :find_user, :except => [:new, :create]
  before_filter :load_available_plugins, :only => [:new, :create, :edit, :update]

  filter_parameter_logging 'password', 'password_confirmation'

  layout 'admin'

  def edit
    @user = User.find params[:id]
    @selected_plugin_titles = @user.plugins.collect{|p| p.title}
  end

  def update
    @selected_plugin_titles = params[:user][:plugins]
    # Prevent the current user from locking themselves out of the User manager
    if current_user.id == @user.id and !params[:user][:plugins].include?("Users")
      flash.now[:error] = "You cannot remove the 'Users' plugin from the currently logged in account."
      render :action => "edit"
    else
      @previously_selected_plugins_titles = @user.plugins.collect{|p| p.title}
      if @user.update_attributes params[:user]
        flash[:notice] = "'#{@user.email}' was successfully updated."
        redirect_to admin_users_url
      else
        @user.plugins = @previously_selected_plugins_titles
        @user.save
        render :action => 'edit'
      end
    end
  end

protected

  def can_create_public_user
    true
  end

  def load_available_plugins
    @available_plugins = Refinery::Plugins.registered.in_menu.titles.sort
  end

end
