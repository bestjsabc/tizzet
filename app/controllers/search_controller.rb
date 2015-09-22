class SearchController < ApplicationController
 
  def index
    @query = params[:query].gsub('_', ' ')
    conditions = ['host like ? or visitor like ? or event like ? or location like ? or territory_state like ? or event_type like ?', *(['%' + @query + '%'] * 6)]
    @tickets = Product.available.find :all, :conditions => conditions, :order => 'created_at DESC'
  end

end
