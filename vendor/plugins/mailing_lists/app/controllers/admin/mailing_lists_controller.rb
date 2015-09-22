class Admin::MailingListsController < Admin::BaseController

  crudify :mailing_list, :title_attribute => :name

end
