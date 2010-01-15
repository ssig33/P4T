class HomeController < ApplicationController
  before_filter :login_check

  def index
    @title = "home"
    @articles = Article.paginate(:page => params[:page],
      :per_page => 20,
      :conditions => ['user_id = ?', session[:login_id]],
      :order => 'created_at desc')
  end
end
