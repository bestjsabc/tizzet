class Admin::MembersController < Admin::BaseController

  crudify :member, :title_attribute => :email

end
