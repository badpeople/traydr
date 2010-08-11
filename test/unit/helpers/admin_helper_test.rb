require 'test_helper'
require 'action_view/test_case'


class AdminHelperTest < ActionView::TestCase
  include ApplicationHelper

  def test_paypal_price
    assert_equal(paypal_price_format("125.00"),"125.00")
    assert_equal(paypal_price_format(125),"125.00")
    assert_equal(paypal_price_format(10.1111),"10.11")
    assert_equal(paypal_price_format(19999990.1111),"19999990.11")
    assert_equal(paypal_price_format(0.05),"0.05")
  end

  def test_fix_url
    assert_equal(fix_url("www.10baggerstocks.com"),"http://www.10baggerstocks.com")
    assert_equal(fix_url("http://www.10baggerstocks.com"),"http://www.10baggerstocks.com")
    assert_equal(fix_url("www.twitter.com/10baggerstocks"),"http://www.twitter.com/10baggerstocks")
  end
end
