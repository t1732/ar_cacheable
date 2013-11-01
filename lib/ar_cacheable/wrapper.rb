module ArCacheable
  class Wrapper
    def initialize(instance)
      @instance = instance
    end

    def cache_key(key)
      "#{@instance.class.name}-#{@instance.id}-#{key}"
    end

    def [](key)
      read(key)
    end

    def []=(key, value)
      write(key, value)
    end

    def read(key)
      ArCacheable.config.cache_store.read(cache_key(key))
    end

    def write(key, value, options = {})
      ArCacheable.config.cache_store.write(cache_key(key), value, options)
    end

    def exist?(key)
      ArCacheable.config.cache_store.exist?(cache_key(key))
    end
  end

end
