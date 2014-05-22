module ArCacheable
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def ar_cacheable(last_changes: [])
        include Caching
        if last_changes
          class_attribute :ar_cacheable_columns
          self.ar_cacheable_columns = [last_changes].flatten.compact.collect(&:to_s)
          include CachingLastChanges
        end
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
