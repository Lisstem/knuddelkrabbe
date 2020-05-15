require 'rubygems'
require 'bundler/setup'
require 'tilt/haml'
require 'tilt/sass'

Encoding.default_external = 'utf-8'

def render(partial, content={}, &block)
  Tilt::HamlTemplate.new("src/#{partial}.haml").render(self, content, &block)
end
sites = ['index']
template = Tilt.new('src/main.haml')
sites.each do |site|
  html = File.open("html/#{site}.html", 'w')
  html.puts template.render(self, site: site, construction: true)
  html.close
end