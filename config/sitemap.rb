# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.panadata.net"
# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'
# store on S3 using Fog
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com/"
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

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
  #
  # Add all articles:
  #
     
     add licitations_path, :changefreq => 'hourly'

     Licitation.find_each do |licitation|
       add licitation_path(licitation), :lastmod => licitation.updated_at, :changefreq => 'yearly'
     end

     add corporations_path, :changefreq => 'hourly'

     Corporation.find_each do |corporation|
       add corporation_path(corporation), :lastmod => corporation.updated_at, :changefreq => 'yearly'
     end

     add brands_path, :changefreq => 'hourly'

     Brand.find_each do |brand|
       add brand_path(brand), :lastmod => brand.updated_at, :changefreq => 'yearly'
     end
end
