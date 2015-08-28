require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    item = LineItem.new
    item.product = products(:ruby)
    orders(:one).line_items << item
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match /1 x Programming Ruby \d\.\d/, mail.body.encoded
  end

  test "shipped" do
    item = LineItem.new
    item.product = products(:ruby)
    orders(:one).line_items << item
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match /<td>Programming Ruby \d\.\d<\/td>/, mail.body.encoded
  end

end
