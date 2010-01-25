class StreamController < ApplicationController
  def stream
    if session[:login_id]
      @login_user = User.find_by_id(session[:login_id])
    end
    @user = User.find_by_screen_name(params[:id])
    @articles = Article.paginate(:page => params[:page],
      :per_page => 20,
      :include => :user,
      :conditions => ['users.screen_name = ?', params[:id]],
      :order => 'articles.created_at desc')
    @title = 'Stream - '+@user.screen_name
  end

  def atom
    @user = User.find_by_screen_name(params[:id])
    @articles = Article.paginate(:page => params[:page],
      :per_page => 20,
      :include => :user,
      :conditions => ['users.screen_name = ?', params[:id]],
      :order => 'articles.created_at desc')
    @articles = Article.render_markdown_articles(@articles)
  end
end
