# == Schema Information
#
# Table name: user
#
#  userID         :integer          not null, primary key
#  companyID      :integer          default(1), not null
#  username       :string(45)       not null
#  password       :string(40)       not null
#  firstName      :string(45)       not null
#  lastName       :string(45)       not null
#  email          :string(45)       not null
#  phone          :string(45)       not null
#  title          :string(255)
#  role           :string(13)       not null
#  enabled        :boolean          default(FALSE), not null
#  verified       :boolean          default(FALSE), not null
#  emailVerified  :boolean          default(FALSE), not null
#  licenseVersion :integer          default(0), not null
#  licenseDate    :date
#  expirationDate :date
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:test_user)
  end

  test 'user authentication with valid password' do
    assert_true(@user.authenticate_signin('foobar'))
  end

  test 'user authentication with invalid password' do
    assert_false(@user.authenticate_signin('foo'))
  end

  test 'user authentication, not ProGauge' do
    @other_user = users(:other_company_user)
    assert_false(@other_user.authenticate_signin('foobar'))
  end
end
