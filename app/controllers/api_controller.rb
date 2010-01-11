class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def post
    @id = Article.post_from_api(params)
    render :text => "http://#{SITE_DOMAIN}/photo/#{@id.to_s}/"
  end
end
