module ArCacheable
  class CacheKeyError < StandardError
    def initialize(message = nil)
      super(message || "Generation of cache key can not be because the id is not been identified.")
    end
  end
end
