Gem::Specification.new do |s|
  s.name        = 'pg_tags'
  s.version     = '0.0.7'
  s.date        = '2015-01-30'
  s.summary     = "pg_tags is a simple and high performance tagging gem for Rails using the PostgreSQL array type."
  s.description = "pg_tags is a simple and high performance tagging gem for Rails using the PostgreSQL array type. An alternative to acts_as_taggable_on. Still a work in progress and not ready for use! "
  s.authors     = ["Yos Riady"]
  s.email       = 'yosriady@gmail.com'
  s.homepage    =
    'http://github.com/Leventhan/pg_tags'
  s.license       = 'MIT'

  s.files         = ["lib/pg_tags.rb", "lib/pg_tags/taggable.rb"]
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  # s.add_runtime_dependency 'activerecord',  ['>= 4', '< 5']
  # s.add_runtime_dependency 'activesupport', ['>= 4', '< 5']

  # s.add_development_dependency 'pg'

  # s.add_development_dependency "bundler", "~> 1.5"
  # s.add_development_dependency "rake"
  # s.add_development_dependency "rspec-rails"
end