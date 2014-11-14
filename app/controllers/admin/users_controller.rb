# -*- coding: utf-8 -*-

class Admin::UsersController < ApplicationController
  before_filter :load_data , :authorize
  layout "application"

  def load_data
    @catalogs_resource = Admin::User.new
  end

  # GET /admin/users GET /admin/users.xml
  #   def index
  #      @admin_users = Admin::User.all
  #
  #      respond_to do |format|
  #         format.html # idx.back.erb
  #         format.xml  { render :xml => @admin_users }
  #      end
  #   end

  # GET /admin/users GET /admin/users.xml
  def index
    @catalogs_resource = Admin::User.paginate(:page =>  params[:page], :per_page => 5)
  end

  # GET /admin/users/1/edit
  def edit
    @catalogs_resource = Admin::User.find(params[:id])
  end

  def show
    @catalogs_resource = Admin::User.find(params[:id])
  end

  def create
    @catalogs_resource = Admin::User.new(params[:admin_user])
    if @catalogs_resource.save
      flash[:notice] = "Registro guardado."
      #@catalogs_resource = Admin::User.order("name ASC")
      @catalogs_resource = Admin::User.paginate(:page =>  params[:page], :per_page => 5)
    end
  end

  def new
    @catalogs_resource = Admin::User.new
  end

  def update
    @catalogs_resource = Admin::User.find(params[:id])

    if @catalogs_resource.update_attributes(params[:admin_user])
      flash[:notice] = "Registro actualizado."
      @catalogs_resource = Admin::User.paginate(:page =>  params[:page], :per_page => 5)
    end
  end

  def destroy
    @catalogs_resource = Admin::User.find(params[:id])
    @catalogs_resource.destroy

    flash[:notice] = "Registro borrado."
    #@catalogs_resource = Admin::User.order("name ASC")
    @catalogs_resource = Admin::User.paginate(:page =>  params[:page], :per_page => 5)
  end

  # GET /admin/users/1 GET /admin/users/1.xml
  #   def show
  #      @admin_user = Admin::User.find(params[:id])
  #
  #      respond_to do |format|
  #         format.html # show.html.erb
  #         format.xml  { render :xml => @admin_user }
  #      end
  #   end

  # GET /admin/users/new GET /admin/users/new.xml
  #   def new
  #      @admin_user = Admin::User.new
  #
  #      respond_to do |format|
  #         format.html # new.html.erb
  #         format.xml  { render :xml => @admin_user }
  #      end
  #   end

   

  # POST /admin/users POST /admin/users.xml
  #   def create
  #      @admin_user = Admin::User.new(params[:admin_user])
  #
  #      respond_to do |format|
  #         if @admin_user.save
  #            format.html { redirect_to(@admin_user, :notice => 'User was successfully created.') }
  #            format.xml  { render :xml => @admin_user, :status => :created, :location => @admin_user }
  #         else
  #            format.html { render :action => "new" }
  #            format.xml  { render :xml => @admin_user.errors, :status => :unprocessable_entity }
  #         end
  #      end
  #   end

  # PUT /admin/users/1 PUT /admin/users/1.xml
  #   def update
  #      @admin_user = Admin::User.find(params[:id])
  #
  #      respond_to do |format|
  #         if @admin_user.update_attributes(params[:admin_user])
  #            format.html { redirect_to(@admin_user, :notice => 'User was successfully updated.') }
  #            format.xml  { head :ok }
  #         else
  #            format.html { render :action => "edit" }
  #            format.xml  { render :xml => @admin_user.errors, :status => :unprocessable_entity }
  #         end
  #      end
  #   end

  # DELETE /admin/users/1 DELETE /admin/users/1.xml
  #   def destroy
  #      @admin_user = Admin::User.find(params[:id])
  #      @admin_user.destroy
  #
  #      respond_to do |format|
  #         format.html { redirect_to(admin_users_url) }
  #         format.xml  { head :ok }
  #      end
  #   end
end
