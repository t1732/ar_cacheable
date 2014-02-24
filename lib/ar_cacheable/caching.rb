require 'ar_cacheable/wrapper'

module ArCacheable
  module Caching
    extend ActiveSupport::Concern

    module ClassMethods
      def ar_cacheable?
        true
      end
    end

    def cache
      @_object_cache_ ||= Wrapper.new(self)
    end

    def last_changes
      cache[:last_changes]
    end
  end
end
