class Post < ActiveRecord::Base
  has_tags :tags, :authors
end
