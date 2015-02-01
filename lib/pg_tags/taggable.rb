module PgTags
  module Taggable
    def self.included(base)
      base.extend(ClassMethod)
    end

    module ClassMethod
      def has_tags(tag_name=:tags, options={})

        #== Scopes
        scope :"with_any_#{tag_name}", ->(tags){ where("#{tag_name} && ARRAY[?]::varchar[]", tags) }
        scope :"with_all_#{tag_name}", ->(tags){ where("#{tag_name} @> ARRAY[?]::varchar[]", tags) }
        # with_only_#{tag_name}
        # with_similar_#{tag_name}
        scope :"without_any_#{tag_name}", ->(tags){ where.not("#{tag_name} && ARRAY[?]::varchar[]", tags) }
        scope :"without_all_#{tag_name}", ->(tags){ where.not("#{tag_name} @> ARRAY[?]::varchar[]", tags) }

        self.class.class_eval do
          define_method :"all_#{tag_name}" do |options = {}, &block|
            subquery_scope = unscoped.select("unnest(#{table_name}.#{tag_name}) as tag").uniq
            subquery_scope = subquery_scope.instance_eval(&block) if block

            from(subquery_scope).pluck('tag')
          end

          define_method :"#{tag_name}_cloud" do |options = {}, &block|
            subquery_scope = unscoped.select("unnest(#{table_name}.#{tag_name}) as tag")
            subquery_scope = subquery_scope.instance_eval(&block) if block

            from(subquery_scope).group('tag').order('tag').pluck('tag, count(*) as count')
          end

          # {tag_name}s_cloud
          # most_used_#{tag_name}s
          # least_used_#{tag_name}s
        end
      end
    end

    # Instance methods
    def some_instance_method
      puts "some_instance_method"
    end

    # Need to add methods to easily set tags
    # <<
    # tags.add
    # tags.remove



  end
end