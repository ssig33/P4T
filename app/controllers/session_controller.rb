class SessionController < ApplicationController
  def index
    @title = 'Sign In or Sign Up'
  end

  def oauth
    request_token = User.get_request_token(request)
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def oauth_callback
    access_token = User.get_access_token_from_request_token(
      params, session[:request_token], session[:request_token_secret])
    session[:access_token] = access_token
    redirect_to :action => :check_user
  end

  def check_user
    if User.check_user_from_access_token(session[:access_token])
      session[:login_id] = User.find_by_user_id(
        User.get_user_info_from_access_token(session[:access_token])['id'])
      User.update_access_token_from_login_id_and_access_token(
        session[:login_id], session[:access_token])
      redirect_to :controller => :home
    else
      session[:user_info] = User.get_user_info_from_access_token(
        session[:access_token])
      redirect_to :action => :register
    end
  end

  def register
    @user_info = session[:user_info]
  end

  def insert
    if User.register_from_params_and_access_token_and_user_info(
      params, session[:access_token], session[:user_info])
      session[:login_id] = User.find_by_user_id(session[:user_info]['id'])
      redirect_to :controller => :home
    else
      flash[:error] = "Can't register with that Screen Name."
      redirect_to :action => :register
    end
  end

  def sign_in
    if session[:login_id] = User.sign_in(params[:screen_name], params[:password])
      redirect_to :controller => :home
    else
      flash[:error] = 'Invalid Screen Name or Password.'
      redirect_to :action => :index
    end
  end

  def kill
    session[:login_id] = nil
    redirect_to :action => :index
  end
end
