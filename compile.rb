require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'tilt/haml'
require 'tilt/sass'

Encoding.default_external = 'utf-8'

def render(partial, content={}, &block)
  Tilt::HamlTemplate.new("src/#{partial}.haml").render(self, content, &block)
end

impressum_data = YAML.load_file('impressum_data.yaml')
sites = ['index', 'impressum']
template = Tilt.new('src/main.haml')
sites.each do |site|
  html = File.open("html/#{site}.html", 'w')
  html.puts template.render(self, site: site, construction: true, impressum: impressum_data)
  html.close
end

template = Tilt.new('src/style.sass')
css = File.open('css/style.css', 'w')
css.puts template.render(self)
css.close