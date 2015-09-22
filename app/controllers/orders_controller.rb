class OrdersController < ApplicationController
  
  def index
    @orders = Order.find_all_by_buyer_id( self.current_user.id )
  end
  
  def create
    @order = Order.new(params[:order])
    @ticket = @order.ticket
    @order.buyer_ip_address = request.remote_ip
    @order.buyer = current_user
    if @order.purchase!
      render "success"
    else
      render "tickets/buy"
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def ship
    @tickets = Ticket.find_all_by_seller_id( current_user.id )
    @order = Order.find(params[:id])
    @order.tracking_number = params[:order][:tracking_number]
    @order.shipped = Date.now
    @order.save
    # Don't care if the save was successful or not; we are sending you to tickets/index regardless.
    render "tickets/index"
  end
end
