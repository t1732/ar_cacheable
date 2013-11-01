# -*- coding: utf-8 -*-
require 'active_support/configurable'
require 'active_support/cache/memory_store'

module ArCacheable
  def self.configure(&block)
    yield @config ||= ArCacheable::Configuration.new
  end

  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :cache_store
  end

  # this is ugly. why can't we pass the default value to config_accessor...?
  configure do |config|
    config.cache_store = ActiveSupport::Cache::MemoryStore.new
  end
end
