class BannersController < ApplicationController

  #before_filter :find_all_banners
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @banner in the line below:
    present(@page)
  end

  def show
    @banner = Banner.find(:first, :conditions => ["parent_id is NULL and id = ?", params[:id]])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @banner in the line below:
    present(@page)
  end

protected

  def find_all_banners
    @banners = Banner.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/banners")
  end

end
