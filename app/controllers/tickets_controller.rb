class TicketsController < ApplicationController
  before_filter :require_login, :only => [:buy, :new]
  def new
    @ticket = Ticket.new(params[:ticket])
    @state = User.territory_state
  end

  def create
    puts params[:ticket].inspect
    @ticket = Ticket.new(params[:ticket])
    #@ticket.price = params[:ticket][:price]
    @ticket.seller_id = current_user.id
    if @ticket.valid?
      @ticket.save!
      flash[:notice]  = "Your ticket is all set up."
      redirect_back_or_default('/')
    else
      flash[:error]  = "Tizzet can't sell this ticket until you meet our finicky system's needs."
      redirect_to params.merge({:action => 'new'})
    end
  end

  def show
    redirect_to :action => :buy
  end
  
  def buy
    # A form that creates a new "order"
    @ticket = Ticket.find(params[:id])
    @order = Order.new(params[:order])
    
  end

  def index
    @tickets = Product.find :all #_all_by_seller_id( current_user.id )
    render :template => '/search/index.html.erb'
  end

end
