module PgTags
  module Taggable
    def self.included(base)
      base.extend(ClassMethod)
    end

    module ClassMethod
      def has_tags(*tag_types)
        tag_types = tag_types.to_a.flatten.compact.map(&:to_sym)

        class_eval do
          class_attribute :tag_types
          self.tag_types = tag_types
        end

        tag_types.each do |tag_type|
          #== Scopes
          scope :"with_any_#{tag_type}", ->(tags){ where("#{tag_type} && ARRAY[?]::varchar[]", tags) }
          scope :"with_all_#{tag_type}", ->(tags){ where("#{tag_type} @> ARRAY[?]::varchar[]", tags) }
          scope :"without_any_#{tag_type}", ->(tags){ where.not("#{tag_type} && ARRAY[?]::varchar[]", tags) }
          scope :"without_all_#{tag_type}", ->(tags){ where.not("#{tag_type} @> ARRAY[?]::varchar[]", tags) }

          self.class.class_eval do
            define_method :"all_#{tag_type}" do |options = {}, &block|
              subquery_scope = unscoped.select("unnest(#{table_name}.#{tag_type}) as tag").uniq
              subquery_scope = subquery_scope.instance_eval(&block) if block

              from(subquery_scope).pluck('tag')
            end

            define_method :"#{tag_type}_cloud" do |options = {}, &block|
              subquery_scope = unscoped.select("unnest(#{table_name}.#{tag_type}) as tag")
              subquery_scope = subquery_scope.instance_eval(&block) if block

              from(subquery_scope).group('tag').order('tag').pluck('tag, count(*) as count')
            end
          end
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