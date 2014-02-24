module ArCacheable
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def ar_cacheable(last_changes: true)
        include Caching
        include CachingLastChanges if last_changes
      end

      def ar_cacheable?
        false
      end
    end

    def ar_cacheable?
      self.class.ar_cacheable?
    end
  end
end
