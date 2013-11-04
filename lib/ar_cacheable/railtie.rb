module ArCacheable
  class Railtie < Rails::Railtie
    initializer "ar_cacheable.on_load_active_record" do
      ActiveSupport.on_load(:active_record) do
        include ArCacheable::Model
      end
    end

    initializer "ar_cacheable.configure" do
      ArCacheable.configure do |config|
        config.cache_store = Rails.cache
      end
    end
  end

end
