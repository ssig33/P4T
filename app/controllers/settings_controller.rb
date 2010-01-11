class SettingsController < ApplicationController
  before_filter :login_check

  def index
    @title = "Settings"
  end

  def generate_mail
    User.generate_mail(session[:login_id])
    flash[:notice] = 'Your Address has been generated'
    redirect_to :action => :index
  end

  def generate_api_key
    User.generate_api_key(session[:login_id])
    flash[:notice] = 'Your API Key has been generated'
    redirect_to :action => :index
  end

  def password
    @title = "Settings - Change Password"
  end

  def update_password
    if User.update_password_from_settings_form(session[:login_id], params)
      flash[:notice] = 'Your Password has been changed'
      redirect_to :action => :index
    else
      flash[:error] = 'Fail'
      redirect_to :action => :password
    end
  end

  def delete_account
    @title = "Settings - Delete My Account"
  end

  def destroy; raise; end
end
