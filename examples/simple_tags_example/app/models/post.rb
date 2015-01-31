class Post < ActiveRecord::Base
  has_tags :tags
  has_tags :authors
end
