require_relative "spec_helper"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define do
  create_table :users, :force => true do |t|
    t.string :name
    t.integer :age
  end
end

ActiveRecord::Base.send(:include, ArCacheable::Model)

class User < ActiveRecord::Base
end

class UserCachable < User
  ar_cacheable
end

class NoCacheable < User
end

class LastChangesNotCached < User
  ar_cacheable :last_changes => false
end

class TargettingCacned < User
  ar_cacheable :last_changes => :name
end

describe do
  let(:no_cache_model) { NoCacheable }
  let(:model) { UserCachable }
  let(:last_changes_not_cached_model) { LastChangesNotCached }
  let(:targetting_model) { TargettingCacned }

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

    it "can be delete" do
      @instance.cache.delete(:hoge)
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
      before { @instance.update(:name => "(update)", :age => 20)}

      it do
        @instance.reload
        expect(@instance.last_changes).to eq({ "name" => ["(name)", "(update)"], "age" => [nil, 20] })
      end
    end

    context "not cached last_changes" do
      before do
        @instance = last_changes_not_cached_model.create(:name => "(name)")
        @instance.update(:name => "(update)")
      end

      it do
        @instance.reload
        expect(@instance.last_changes).to be_nil
      end
    end


    context "cached last_changes only target column" do
      before do
        @instance = targetting_model.create(:name => "(name)", :age => 20)
        @instance.update(:name => "(update)", :age => 30)
      end

      it do
        @instance.reload
        expect(@instance.last_changes).to eq({ "name" => ["(name)", "(update)"] })
      end
    end
  end

  it "is not possible to cache the new record" do
    expect{
      model.new.cache.write(:foo, "test")
    }.to raise_error(ArCacheable::CacheKeyError)
  end
end
