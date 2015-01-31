module PgTags
  module Taggable
    def self.included(base)
      base.extend(ClassMethod)
    end

    module ClassMethod
      def has_tags(tag_name)

        #== Scopes
        scope :"with_any_#{tag_name}", ->(tags){ where("#{tag_name} && ARRAY[?]::varchar[]", tags) }
        scope :"with_all_#{tag_name}", ->(tags){ where("#{tag_name} @> ARRAY[?]::varchar[]", tags) }
        # with_only_#{tag_name}
        # with_related_#{tag_name}
        scope :"without_any_#{tag_name}", ->(tags){ where.not("#{tag_name} && ARRAY[?]::varchar[]", tags) }
        scope :"without_all_#{tag_name}", ->(tags){ where.not("#{tag_name} @> ARRAY[?]::varchar[]", tags) }

        self.class.class_eval do

          #== Class methods
          define_method :"all_#{tag_name}" do |options = {}, &block|
            "viewing all #{tag_name}"
          end

          # all_#{tag_name}s
          # {tag_name}s_cloud
          # related_#{tag_name}_to
          # most_used_#{tag_name}s
          # least_used_#{tag_name}s

        end
      end
    end

    # Instance methods
    def some_instance_method
      puts "some_instance_method"
    end
  end
end