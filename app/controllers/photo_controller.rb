class PhotoController < ApplicationController
  def permanent
    if session[:login_id]
      @login_user = User.find_by_id(session[:login_id])
    end
    @article = Article.find(params[:id])
    @title = "<a href=\"/stream/#{@article.user.screen_name}\">"+@article.user.screen_name+'</a> - '+@article.title
  end
end
