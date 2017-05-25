class Notification < ApplicationRecord
  NOTIFICATION_TYPES = {
    :system  => 0,
    :like    => 1,
    :comment => 2
  }.freeze

  STATUS_OK = 0
  STATUS_READ = 1

  belongs_to :user

  belongs_to :like, foreign_type: NOTIFICATION_TYPES[:like], foreign_key: "event_id"
  belongs_to :comment, foreign_type: NOTIFICATION_TYPES[:comment], foreign_key: "event_id"

  validates :event_type, inclusion: { in: NOTIFICATION_TYPES.values }
end
