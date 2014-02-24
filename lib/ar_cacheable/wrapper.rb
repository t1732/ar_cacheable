module ArCacheable
  class Wrapper
    def initialize(instance)
      @instance = instance
    end

    def cache_key(key)
      if @instance.new_record?
        raise CacheKeyError
      else
        [@instance.class.name, @instance.id, key].join(ArCacheable.config.cache_key_separater)
      end
    end

    def [](key)
      read(key)
    end

    def []=(key, value)
      write(key, value)
    end

    def read(key)
      cache_store.read(cache_key(key))
    end

    def write(key, value, options = {})
      cache_store.write(cache_key(key), value, options)
    end

    def delete(key)
      cache_store.delete(cache_key(key))
    end

    def exist?(key)
      cache_store.exist?(cache_key(key))
    end

    private

    def cache_store
      ArCacheable.config.cache_store
    end
  end
end
