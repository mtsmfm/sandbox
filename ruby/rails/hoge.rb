require 'bundler/inline'

gemfile(true) do
  gem 'activerecord', require: 'active_record'
  gem 'sqlite3'
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

class User < ActiveRecord::Base
  connection.create_table(:users, force: true)
end

BasicObject.define_singleton_method(:x) {|**args| }

BasicObject.x(User.new)
