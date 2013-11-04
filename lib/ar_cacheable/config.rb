# -*- coding: utf-8 -*-
require 'active_support/configurable'
require 'active_support/cache/memory_store'

module ArCacheable
  include ActiveSupport::Configurable
  config_accessor :cache_store
  config.cache_store = ActiveSupport::Cache::MemoryStore.new
end
