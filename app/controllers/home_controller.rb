class HomeController < ApplicationController
  before_filter :login_check

  def index
    @title = "home"
    @articles = Article.find(:all,
      :conditions => ['user_id = ?', session[:login_id]],
      :order => 'created_at desc')
  end
end
