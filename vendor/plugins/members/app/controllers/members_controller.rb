class MembersController < ApplicationController
  before_filter :require_no_member, :only => [:new, :create]
  before_filter :require_member, :only => [:show, :edit, :update]
  
  #before_filter :find_all_members
  before_filter :find_page
  before_filter :load_arrays
  
  #def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @member in the line below:
  #  present(@page)
  #end

  def show
    @member = @current_member
    @products = Product.find(:all, :conditions => ["seller_id = ?", @member.id], :order => "created_at DESC")
    @purchases = Purchase.find_all_by_buyer_id(@member.id).select{|t| !t.txn_id.nil?}
    @tickets_sold = Purchase.find_all_by_seller_id(@member.id).select{|t| !t.txn_id.nil?}
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @member in the line below:
    present(@page)
    
    render :layout => 'my_account'
  end
  
  def edit
    @member = @current_member
  end
  
  def update
    
    @member = @current_member
    
    if @member.update_attributes(params[:member])

      flash[:notice] = "Account Updated"
      redirect_to member_path(@member)
      
    end
    
  end
  
  def new
    @member = Member.new
    @page = Page.find_by_title("Signup")
    present(@page)
  end
  
  def create
    @member = Member.new(params[:member])
    if @member.save
      UserMailer.deliver_signup_thankyou(@member)
      flash[:notice] = "Account registered!"
      #redirect_back_or_default account_url
      redirect_to "/"
    else
      render :action => :new
    end
  end

protected

  def find_all_members
    @members = Member.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/members")
  end
  
private

  def load_arrays
    @salutation = Member.salutation
    @referal = Member.referal
    @state = Member.territory_state
  end

end
