# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://shirobuhi.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  add root_path
  add home_path
  add search_path
  add mypage_path
  add '/users/sign_in'
  add '/users/sign_up'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  Video.find_each do |video|
    add video_path(video.id), lastmod: video.updated_at
  end
end
