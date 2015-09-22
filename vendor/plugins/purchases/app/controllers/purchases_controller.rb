class PurchasesController < ApplicationController
  
  #before_filter :find_all_purchases
  before_filter :find_page, :require_member

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @purchase in the line below:
    #present(@page)
  end

  def show
    @purchase = Purchase.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @purchase in the line below:
    present(@page)
  end
  
  def new
    @purchase = Purchase.new
    @ticket = Product.available.find(params[:product_id])
    present(@page)
  end
  
  def create
    
    @purchase = Purchase.new(params[:purchase])
    @ticket = Product.find(params[:purchase][:product_id])
    
    @purchase.payment_status = 1
    @purchase.buyer_id = params[:purchase][:buyer_id]
    @purchase.event = @ticket.event
    @purchase.date = @ticket.date
    @purchase.start_time = @ticket.start_time
    @purchase.seating_type = @ticket.seating_type
    @purchase.seller_id = @ticket.seller_id
    @purchase.location = @ticket.location
    @purchase.seating_block = @ticket.seating_block unless @ticket.seating_block.nil?
    @purchase.seating_row = @ticket.seating_row unless @ticket.seating_row.nil?
    @purchase.seat_number = @ticket.seat_number unless @ticket.seat_number.nil?
    
    if @purchase.save
      
      present(@page)

    else
      render :action => "new"
    end
  end
  
  def received
    
    @purchase = Purchase.find(params[:id])
    @purchase.received = true
    @purchase.save
    
    redirect_to :controller => 'members', :action => 'show', :id => current_user.id
    
  end
  
  def thank_you
    present(@page)
  end

protected

  def find_all_purchases
    @purchases = Purchase.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/purchases")
  end

end
