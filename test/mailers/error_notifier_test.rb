require 'test_helper'

class ErrorNotifierTest < ActionMailer::TestCase
  test "notify_error" do
    error = ActiveRecord::RecordNotFound.new('Foobar error')
    mail = ErrorNotifier.notify_error(error)
    assert_equal "Depot App Error", mail.subject
    assert_equal ["admin@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Foobar error", mail.body.encoded
  end
end
