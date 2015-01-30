$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'active_record/railtie'
ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = 3

require 'pg_tags'

ActiveRecord::Migration.verbose = false

class Post < ActiveRecord::Base; end

RSpec.configure do |config|
  config.before(:all) do
    ActiveRecord::Base.establish_connection(
      adapter: "postgresql",
      encoding: 'unicode',
      database: "pg_tags_test",
      username: "pg_tags"
    )
    create_database
  end

  config.after(:all) do
    drop_database
  end

  config.after(:each) do
    Post.delete_all
  end
end

def create_database
  ActiveRecord::Schema.define(:version => 1) do
    create_table :posts do |t|
      t.string :tags, array: true, default: '{}'
      t.timestamps
    end
  end
end

def drop_database
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end