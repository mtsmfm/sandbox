require 'bundler/setup'

require 'rails'
require 'action_controller/railtie'

Bundler.require

module Foo
  class Application < Rails::Application
    config.secret_key_base = 'a' * 50
    config.secret_token = 'a' * 50
  end
end

Rails.application.initialize!

class RackTest
  def call(env)
    [200, {'Content-Type' => 'text/plain'}, [env['PATH_INFO']]]
  end
end

Rails.application.routes.draw do
  mount RackTest.new => "/testing"
end

run Rails.application
