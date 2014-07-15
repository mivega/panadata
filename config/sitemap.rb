# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.panadata.net"
# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'
# store on S3 using Fog
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com/"
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
     
     add licitations_path, :changefreq => 'hourly'

     Licitation.find_each do |licitation|
       add licitation_path(licitation.acto),  :changefreq => 'yearly'
     end

     add corporations_path, :changefreq => 'hourly'

     Corporation.find_each do |corporation|
       add corporation_path(corporation),  :changefreq => 'yearly'
     end

     add brands_path, :changefreq => 'hourly'

     Brand.find_each do |brand|
       add brand_path(brand),  :changefreq => 'yearly'
     end

     add owners_path, :changefreq => 'hourly'

     Owner.find_each do |o|
       add owner_path(p),  :changefreq => 'yearly'
     end

     add personas_path, :changefreq => 'hourly'

     Persona.find_each do |p|
       add persona_path(p),  :changefreq => 'yearly'
     end

     add contraloria_path, :changefreq => 'hourly'

     ContraloriaDoc.find_each do |p|
       add contralorium_path(p),  :changefreq => 'yearly'
     end

end
