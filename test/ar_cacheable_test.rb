require 'test_helper'

class ArCacheableTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ArCacheable
  end
end
