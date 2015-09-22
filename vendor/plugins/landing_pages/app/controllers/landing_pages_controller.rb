class LandingPagesController < ApplicationController
  
  before_filter :find_landing_page

  def show
    query = @landing_page.title.split    
    
    @tickets = []
    
    query.each do |k|
      conditions = ['event like ?', ['%' + k + '%']]
      @tickets += Product.available.find(:all, :conditions => conditions)
    end
    
  end
  

  private
  def find_landing_page
    @landing_page = LandingPage.find(params[:id]) if params[:id]
    present(@landing_page)
  end
end