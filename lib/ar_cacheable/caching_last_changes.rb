module ArCacheable
  module CachingLastChanges
    extend ActiveSupport::Concern

    included do
      after_save do
        cache[:last_changes] = changes
      end
    end
  end
end
