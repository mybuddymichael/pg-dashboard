require 'test_helper'

class CiProjectTest < ActiveSupport::TestCase
  test "last_build returns a CiBuild" do
    assert_equal(CiProject.all.first.last_build.class, CiBuild)
    assert_equal(CiProject.all.last.last_build.class, CiBuild)
  end
end
