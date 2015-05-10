require 'bundler'
Bundler.require

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/js'

  RailsAssets.load_paths.each {|p| environment.append_path(p) }

  Opal.use_gem 'activesupport'
  Opal.use_gem 'opal-jquery'
  Opal.paths.each {|p| environment.append_path(p) }

  run environment
end

map '/' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/html'
  environment.register_engine '.slim', Slim::Template

  run environment
end
