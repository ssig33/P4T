require 'net/pop'

class Fetcher < ActionMailer::Base
  def self.fetch
    pop = Net::POP3.new(POP_SERVER, POP_PORT)
    pop.start(POP_USER, POP_PASS)
      if pop.mails.empty?
        puts 'No Mail'
      else
        pop.each_mail do |m|
          receive(m.pop)
        end
      end
    pop.finish
  end

  def receive(email)
    begin
      if (email.attachments[0] and user = User.find_by_mail(email.to[0]))
        begin
          img = Magick::ImageList.new
          img.from_blob(email.attachments[0].read)
          article = Article.new
          article.comments = email.body.gsub!(/Attachment:\ (.*)/, "")
          article.user_id = user.id
          article.save
          response = User.post_to_twitter(user.id, 
            article.comments, 
            "http://#{SITE_DOMAIN}/photo/"+article.id.to_s)
          img.write("public/photos/#{article.id.to_s}.png")
          puts "success"
        rescue => error
          article.destroy
          puts error
        end
      end
    rescue
    end
  end
end
