class IndexController < ApplicationController
  def index
    if session[:login_id]
      @login_user = User.find_by_id(session[:login_id])
    end
    @articles = Article.paginate(:page => params[:page],
      :per_page => 20,
      :include => :user,
      :order => 'articles.created_at desc')
    @title = "Photos for Twitter"
  end

  def atom
    if session[:login_id]
      @login_user = User.find_by_id(session[:login_id])
    end
    @articles = Article.paginate(:page => params[:page],
      :per_page => 20,
      :include => :user,
      :order => 'articles.created_at desc')
  end
end
