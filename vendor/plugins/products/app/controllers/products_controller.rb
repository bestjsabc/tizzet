class ProductsController < ApplicationController
  before_filter :require_member, :only => [:new, :create, :edit, :update, :destroy]
  #before_filter :require_no_member, :only => [:index, :show]
  
  #before_filter :find_all_products
  before_filter :find_page

  def index
    #@products = Product.find :all #_all_by_seller_id( current_user.id )
    #render :template => '/search/index.html.erb'
    if params[:query]
      @query = params[:query].gsub('+', ' ')
      conditions = ['host like ? or visitor like ? or event like ? or location like ? or territory_state like ? or event_type like ?', *(['%' + @query + '%'] * 6)]
      @products = Product.available.find :all, :conditions => conditions
    else
      @products = Product.available.find :all, :order => 'created_at DESC'
    end
    @page = Page.find_by_title("Products")
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @product in the line below:
    present(@page)
  end

  def show
    @ticket = Product.find(params[:id])
    @purchase = Purchase.new
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @product in the line below:
    present(@page)
  end
  
  def edit
    @product = Product.find(params[:id])
    if @product.seller_id == current_member.id
      @state = Member.territory_state
    else
      flash[:notice] = "You are not allowed to alter this entry."
      redirect_back_or_default("/")
    end
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Ticket details successfully updated."
      redirect_to url_for(current_member)
    else
      render :action => "edit"
    end
  end
  
  def new
    @product = Product.new(params[:product])
    @state = Member.territory_state
  end
  
  def create
    @product = Product.new(params[:product])
    @state = Member.territory_state
    @product.quantity_on_hand = params[:product][:quantity]
    @product.quantity_sold = 0
    @product.seller_id = current_member.id
    @product.status = 1
    if @product.save
      flash[:notice]  = "Your ticket is all set up."
      redirect_to url_for(current_member)
    else
      render params.merge({:action => 'new'})
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Ticket deleted"
    redirect_to url_for(current_member)
  end

protected

  def find_all_products
    @products = Product.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/products")
  end

end
