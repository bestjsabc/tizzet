# Filters added to this controller apply to all controllers in the refinery backend.
# Likewise, all the methods added will be available for all controllers in the refinery backend.

# You can extend refinery backend with your own functions here and they will likely not get overriden in an update.

class Admin::BaseController < Refinery::AdminBaseController
  before_filter :require_superuser
private
  def require_superuser
    unless current_user && current_user.superuser
      flash[:error] = "You are not authorized to use the admin section"
      redirect_to '/'
    end
  end
end
