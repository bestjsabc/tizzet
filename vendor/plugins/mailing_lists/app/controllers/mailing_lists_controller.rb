class MailingListsController < ApplicationController

  #before_filter :find_all_mailing_lists
  before_filter :find_page

  #def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @mailing_list in the line below:
  #  present(@page)
  #end

  #def show
  #  @mailing_list = MailingList.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @mailing_list in the line below:
  #  present(@page)
  #end
  
  def create
    if params[:name] && params[:email]
      @subscriber = MailingList.new(:name => params[:name], :email => params[:email])
      @subscriber.save
      UserMailer.deliver_mailing_list_thankyou(@subscriber)
      
      render :action => "thank_you"
    else
      flash[:notice] = "Please verify your name and email address"
      redirect_to "/"
    end
  end
  
  def thank_you
    present(@page)
  end

protected

  def find_all_mailing_lists
    @mailing_lists = MailingList.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/mailing_lists")
  end

end
