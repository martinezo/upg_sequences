class Admin::PricesController < ApplicationController
  # GET /admin/prices
  # GET /admin/prices.xml
  before_filter :authorize
  layout 'application'

  def index
    @admin_prices = Admin::Price.all

    respond_to do |format|
      format.html # idx.back.erb
      format.xml  { render :xml => @admin_prices }
    end
  end

  # GET /admin/prices/1
  # GET /admin/prices/1.xml
  def show
    @admin_price = Admin::Price.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_price }
    end
  end

  # GET /admin/prices/new
  # GET /admin/prices/new.xml
  def new
    @admin_price = Admin::Price.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_price }
    end
  end

  # GET /admin/prices/1/edit
  def edit
    @admin_price = Admin::Price.find(params[:id])
  end

  # POST /admin/prices
  # POST /admin/prices.xml
  def create
    @admin_price = Admin::Price.new(params[:admin_price])

    respond_to do |format|
      if @admin_price.save
        format.html { redirect_to(@admin_price, :notice => 'Price was successfully created.') }
        format.xml  { render :xml => @admin_price, :status => :created, :location => @admin_price }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_price.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/prices/1
  # PUT /admin/prices/1.xml
  def update
    @admin_price = Admin::Price.find(params[:id])

    respond_to do |format|
      if @admin_price.update_attributes(params[:admin_price])
        format.html { redirect_to(:action => 'index', :notice => 'Price was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_price.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/prices/1
  # DELETE /admin/prices/1.xml
  def destroy
    @admin_price = Admin::Price.find(params[:id])
    @admin_price.destroy

    respond_to do |format|
      format.html { redirect_to(admin_prices_url) }
      format.xml  { head :ok }
    end
  end
end
