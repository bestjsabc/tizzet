class Admin::LandingPagesController < Admin::BaseController

  crudify :landing_page, :title_attribute => :title

end