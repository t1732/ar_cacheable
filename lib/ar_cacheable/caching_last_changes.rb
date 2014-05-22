module ArCacheable
  module CachingLastChanges
    extend ActiveSupport::Concern

    included do
      after_save do
        cache[:last_changes] = changed_cache
      end

      def changed_cache
        if ar_cacheable_columns.empty?
          changes
        else
          changes.reject{|key, value| !key.in?(ar_cacheable_columns) }
        end
      end
    end
  end
end
