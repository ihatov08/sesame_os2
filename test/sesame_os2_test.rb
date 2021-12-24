# frozen_string_literal: true

require "test_helper"

class SesameOs2Test < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::SesameOs2.const_defined?(:VERSION)
    end
  end

  test "something useful" do
    assert_equal("expected", "actual")
  end
end
