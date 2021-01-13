require 'rack/robotz'
require 'rack/deflater'
require 'rack/contrib/try_static'
require 'rack/anystatus'

use Rack::Robotz, "User-Agent" => "*", "Disallow" => "/" unless ENV['RACK_ENV'] == 'production'

map '/favicon.ico' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

map '/apple-touch-icon-precomposed.png' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

map '/apple-touch-icon.png' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

map '/apple-touch-icon-152x152.png' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

map '/apple-touch-icon-152x152-precomposed.png' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

use Rack::Deflater
use Rack::TryStatic,
    urls: %w[/],
    root: 'build',
    try: ['.html', 'index.html', '/index.html', 'index.xml', '/index.xml'],
    header_rules: [
              [:all, {
                  'Strict-Transport-Security' => 'max-age=31536000; preload',
                  'X-Xss-Protection' => '1; mode=block',
                  'X-Content-Type-Options' => 'nosniff',
                  'X-Frame-Options' => 'DENY',
                  'Content-Security-Policy' => "default-src 'self' www.youtube.com; connect-src data: 'self' https://links.services.disqus.com; font-src data: 'self' https://fonts.typekit.net https://use.typekit.net; img-src 'self' http://happyjedi.pro https://p.typekit.net https://www.googletagmanager.com https://www.google-analytics.com https://c.disquscdn.com https://referrer.disqus.com; style-src 'self' 'unsafe-inline' https://use.typekit.net https://c.disquscdn.com; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://use.typekit.net https://www.googletagmanager.com https://www.google-analytics.com https://js-agent.newrelic.com https://bam.nr-data.net https://happyjedi-pro.disqus.com https://c.disquscdn.com https://disqus.com; child-src https://a.tiles.mapbox.com; frame-src https://a.tiles.mapbox.com https://disqus.com;"
              }],
              [['html'], { 'Content-Type' => 'text/html; charset=utf-8'}],
              [['css'], { 'Content-Type' => 'text/css'}],
              [['js'], { 'Content-Type' => 'text/javascript' }],
              [['png'], { 'Content-Type' => 'image/png' }],
              [['gif'], { 'Content-Type' => 'image/gif' }],
              [['jpeg'], { 'Content-Type' => 'image/jpeg' }],
              [['jpg'], { 'Content-Type' => 'image/jpeg' }],
              [['zip'], { 'Content-Type' => 'application/zip' }],
              [['pdf'], { 'Content-Type' => 'application/pdf' }],
              [['xml'], { 'Content-Type' => 'application/rss+xml' }],
              [['/assets'], { 'Cache-Control' => 'public, max-age=31536000', 'Vary' => 'Accept-Encoding' }]
          ]

run lambda { |env|
  [404, { 'Content-Type' => 'text/html' }, File.open('build/404.html', File::RDONLY)]
}

#run Rack::Jekyll.new