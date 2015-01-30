# pg_tags
pg_tags is a simple and high performance tagging gem for Rails using the PostgreSQL array type. An alternative to acts_as_taggable_on. **This is still a work in progress.**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pg_tags'
```

And then execute:

```shell
bundle
```


## Setup

To use it, you need to have an array column to act as taggable.

```ruby
class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :tags, array: true, default: '{}'
      t.timestamps
    end
    add_index :posts, :tags, using: 'gin'
  end
end
```

and bundle:

```shell
rake db:migrate
```

then

```ruby
class User < ActiveRecord::Base
  has_tags :tags
end
@post = Post.new
```

pg_tags defines the following scope and class methods.

### scopes

- with_any_#{tag_name}
- with_all_#{tag_name}
- without_any_#{tag_name}
- without_all_#{tag_name}

### class methods

- all_#{tag_name}
- #{tag_name}_cloud


## Usage

Set, add and remove

```ruby
#set
@user.tags = ["awesome", "slick"]
@user.tags = '{awesome,slick}'

#add
@user.tags += ["awesome"]
@user.tags += ["awesome", "slick"]

#remove
@user.tags -= ["awesome"]
@user.tags -= ["awesome", "slick"]
```


### All Tags

Can get all tags easily.

```ruby
User.all_tags
# ['awesome', 'slick']
```

As the same to tag cloud calculation, you can use block to add scopes to the query.


```ruby
User.all_tags { where name: ['ken', 'tom'] }
```

To handle the result tags named 'tag', prepend scopes.

```ruby
User.where('tag like ?', 'aws%').all_tags { where name: ['ken', 'tom'] }
```

## Benchmark
TODO


## Contributing

1. Fork it ( http://github.com/Leventhan/pg_tags/fork )
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request