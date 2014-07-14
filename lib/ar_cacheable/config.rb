# -*- coding: utf-8 -*-
require 'active_support/configurable'
require 'active_support/cache/memory_store'

module ArCacheable
  include ActiveSupport::Configurable
  config_accessor :cache_store, :cache_key_separater
  config.cache_store = ActiveSupport::Cache::MemoryStore.new
  config.cache_key_separater = ":"
  config.last_changes_expire = 1.minute
end
