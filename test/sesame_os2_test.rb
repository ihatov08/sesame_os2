# frozen_string_literal: true

require "test_helper"

class SesameOs2Test < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::SesameOs2.const_defined?(:VERSION)
    end
  end
end
