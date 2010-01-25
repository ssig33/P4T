class Article < ActiveRecord::Base
  belongs_to :user

  def Article.post_from_api(params)
    begin
      puts params['api_key']
      user = User.find_by_api_key(params['api_key'])
      img = Magick::ImageList.new
      article = Article.new
      img.from_blob(params['imagedata'])
      article.title = params['comment']
      if article.title == nil
        article.title = ''
      end
      article.user_id = user.id
      article.save
      img.write("public/photos/#{article.id.to_s}.png")
      response = User.post_to_twitter(user.id, article.title, "http://#{SITE_DOMAIN}/photo/"+article.id.to_s)
      return article.id.to_s
    rescue => error
      puts error
      article.destroy
    end
  end

  def Article.render_markdown(text)
    unless text == nil
      return BlueCloth.new(text).to_html
    else
      return ""
    end
  end

  def Article.render_markdown_articles(articles)
    articles.each do |a|
      a.comments = Article.render_markdown(a.comments)
    end
    return articles
  end
end
