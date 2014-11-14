# -*- coding: utf-8 -*-

class Admin::UserSessionsController < ApplicationController
  layout "application"

  def new
     @user_session = Admin::UserSession.new
  end

  def create
     @user_session = Admin::UserSession.new(params[:admin_user_session])
     if @user_session.save
        flash[:notice] = 'Sesión de usuario iniciada.'
        redirect_to admin_sequence_requests_path
     else
        render :action => :new
     end
  end

  def destroy
     @user_session = Admin::UserSession.find
     @user_session.destroy
     flash[:notice] = 'Sesión de usuario cerrada.'
     redirect_to admin_login_path
  end
end