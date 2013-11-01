require 'ar_cacheable/config'
require 'ar_cacheable/caching'

module ArCacheable
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

require_relative "ar_cacheable/railtie" if defined?(Rails)
