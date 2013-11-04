module ArCacheable
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def ar_cacheable
        include Caching
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
