atom_feed(:language => 'ja-JP',
          :root_url => 'http://p4t.mobi/',
          :url      => 'http://p4t.mobi/index/atom',
          :id       => 'http://p4t.mobi/') do |feed|
  feed.title    'P4T - Photo for Twitter'
  feed.subtitle 'P4T Photo Stream'
  feed.updated  Time.now
  feed.author{|author| author.name('P4T') }
 
  @articles.each do |a|
    feed.entry(a,
               :url       => 'http://p4t.mobi/photo/'+a.id.to_s,
               :id        => 'http://p4t.mobi/photo/'+a.id.to_s,
               :published => a.created_at,
               :updated   => a.updated_at) do |item|
      item.title(a.user.screen_name+' - '+a.comments)
      item.content("<img src=\"http://p4t.mobi/photos/#{a.id.to_s}.png\" />", :type => 'html')
      item.author{|author| a.user.screen_name }
    end
  end
end
