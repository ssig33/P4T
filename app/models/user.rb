class User < ActiveRecord::Base
  has_many :articles

  def User.oauth_consumer
    return OAuth::Consumer.new(
      CONSUMER,
      CONSUMER_SECRET,
      { :site => "http://twitter.com" }
    )
  end

  def User.get_request_token()
    return oauth_consumer.get_request_token(
      :oauth_callback => "http://#{SITE_DOMAIN}/session/oauth_callback")
  end

  def User.get_access_token_from_request_token(params,
    r_token, r_token_secret )
    request_token = OAuth::RequestToken.new(oauth_consumer,
      r_token, r_token_secret)
    access_token = request_token.get_access_token(
       {},
       :oauth_token => params['oauth_token'],
       :oauth_verifier => params['oauth_verifier']
     )
    return access_token
  end


  def User.check_user_from_access_token(access_token)
    begin
      response = oauth_consumer.request(:get,
        '/account/verify_credentials.json',
        access_token, { :scheme => :query_string })
      puts response.body
      user_info = JSON.parse(response.body)
      if user = User.find_by_user_id(user_info['id'])
        return true
      else
        raise
      end
    rescue
      false
    end
  end

  def User.get_user_info_from_access_token(access_token)
    JSON.parse(oauth_consumer.request(:get,
        '/account/verify_credentials.json',
        access_token, { :scheme => :query_string }).body)
  end
  
  def User.post_to_twitter(user_id, text, url)
    user = User.find_by_id(user_id)
    consumer = oauth_consumer
    access_token = OAuth::AccessToken.new(
      consumer,
      user.access_token,
      user.access_token_secret)
    response =  access_token.post(
      'http://twitter.com/statuses/update.json',
      'status' => text+' '+url)
    return response
  end
 
  def User.register_from_params_and_access_token_and_user_info(
    params, access_token, user_info)
    begin
      user = User.new
      user.user_id = user_info['id']
      user.screen_name = params['screen_name']
      user.password = params['password']
      puts access_token.to_json
      user.access_token = access_token.params['oauth_token']
      user.access_token_secret = access_token.params['oauth_token_secret']
      user.save
      return true
    rescue
      return false
    end
  end

  def User.update_access_token_from_login_id_and_access_token(
    login_id, access_token)
    user = User.find_by_id(login_id)
    user.access_token = access_token.params['oauth_token']
    user.access_token_secret = access_token.params['oauth_token_secret']
    user.save
  end

  def User.sign_in(screen_name, password)
    begin
      user = User.find_by_screen_name(screen_name)
      if user.password == password
        return user.id
      else
        raise
      end
    rescue
      return nil
    end
  end

  def User.generate_mail(user_id)
    user = User.find(user_id)
    a = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    code = (Array.new(20) do
      a[rand(a.size)]
    end ).join
    while User.find_by_mail(code+"@p4t.mobi") != nil
      code = (Array.new(20) do
        a[rand(a.size)]
      end ).join
    end
    user.mail = code+"@p4t.mobi"
    user.save
  end

  def User.generate_api_key(user_id)
    user = User.find(user_id)
    a = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    code = (Array.new(20) do
      a[rand(a.size)]
    end ).join
    while User.find_by_api_key(code) != nil
      code = (Array.new(20) do
        a[rand(a.size)]
      end ).join
    end
    user.api_key = code
    user.save
  end
  
  def User.update_password_from_settings_form(login_id, params)
    begin
      user = User.find_by_id(login_id)
      if user.password == params['current'] and params['password'] == params['password_verify']
        user.password = params['password_verify']
        user.save
      else
        raise
      end
      return true
    rescue
      return false
    end
  end
end
