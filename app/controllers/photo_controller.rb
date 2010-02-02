class PhotoController < ApplicationController
  def permanent
    if session[:login_id]
      @login_user = User.find_by_id(session[:login_id])
    else
      @login_user = User.new
    end
    @article = Article.find(params[:id])
    @article.comments = Article.render_markdown(@article.comments)
    @title = "<a href=\"/stream/#{@article.user.screen_name}\">"+@article.user.screen_name+'</a> - '+@article.title
  end

  def edit
    if session[:login_id]
      @login_user = User.find_by_id(session[:login_id])
      @article = Article.find_by_id(params[:id])
      if @login_user.id != @article.user.id
        redirect_to :action => :permanent, :id => params[:id]
      end
      session[:photo_edit_id] = @article.id
      @title = "<a href=\"/stream/#{@article.user.screen_name}\">"+@article.user.screen_name+'</a> - Edit - '+@article.title
    else
      redirect_to :action => :permanent, :id => params[:id]
    end
  end

  def update
    if Article.find_by_id(params[:article_id]).user.id == User.find_by_id(session[:login_id]).id 
      Article.update(params[:article_id], params[:article])
      flash[:notice] = "Update was Success"
    else
      flash[:error] = "You can't edit that item."
    end
    redirect_to :action => :permanent, :id => params[:article_id]
  end
end
