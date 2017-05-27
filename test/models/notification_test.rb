require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test "should send comment notification" do
    notif = Notification.new
    notif.user_id = 1
    notif.event_type = Notification::NOTIFICATION_TYPES[:comment]
    notif.event_id = 1
    notif.status = Notification::STATUS_OK
    notif.event_from_user_id = 2
    notif.save

    assert notif
  end

  test "should send like notification" do
    notif = Notification.new
    notif.user_id = 1
    notif.event_type = Notification::NOTIFICATION_TYPES[:like]
    notif.event_id = 1
    notif.status = Notification::STATUS_OK
    notif.event_from_user_id = 2
    notif.save

    assert notif
  end

  test "should not send unknown notification" do
    notif = Notification.new
    notif.user_id = 1
    notif.event_type = -1
    notif.event_id = 1
    notif.status = Notification::STATUS_OK
    notif.event_from_user_id = 2

    error = assert_raises(NoMethodError) do
      notif.save
    end
  end
end
