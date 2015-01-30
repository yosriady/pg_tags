require 'active_record'
require "pg_tags/taggable"

ActiveSupport.on_load(:active_record) do
  include PgTags::Taggable
end