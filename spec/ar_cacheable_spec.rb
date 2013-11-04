require_relative "spec_helper"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define do
  create_table :users, :force => true do |t|
    t.string :name
  end
end

ActiveRecord::Base.send(:include, ArCacheable::Model)

class UserNoCacheable < ActiveRecord::Base
end

class User < ActiveRecord::Base
  ar_cacheable
end

describe do
  let(:no_cache_model) { UserNoCacheable }
  let(:model) { User }

  # clean cache data
  before { ArCacheable.config.cache_store.clear }

  it "is not ar_cacheable" do
    expect(no_cache_model.ar_cacheable?).to be_false
  end

  it "is ar_cacheable" do
    expect(model.ar_cacheable?).to be_true
  end

  describe do
    before { @instance = model.create(:name => "(name)") }

    it "can be write" do
      @instance.cache.write(:hoge, "(test)")
    end

    it "can be read" do
      expect(@instance.cache.read(:hoge)).to be_nil
    end

    context "read, write alias" do
      it do
        @instance.cache[:hoge] = "(alias)"
        expect(@instance.cache[:hoge]).to eq("(alias)")
      end
    end

    context "cached changes" do
      before { @instance.update_attributes(:name => "(update)") }

      it do
        @instance.reload
        expect(@instance.last_changes).to eq({"name" => ["(name)", "(update)"]})
      end
    end
  end

end
