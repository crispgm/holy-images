class Notification < ApplicationRecord
  NOTIFICATION_TYPES = {
    :system  => 0,
    :like    => 1,
    :comment => 2
  }.freeze

  NOTIFICATION_CLASS = {
    1 => "Like",
    2 => "Comment"
  }.freeze

  STATUS_OK = 0
  STATUS_READ = 1

  belongs_to :user
  belongs_to :event_from_user, class_name: "User"

  belongs_to :event, polymorphic: true

  belongs_to :like, optional: true, foreign_type: "Like", foreign_key: "event_id"
  belongs_to :comment, optional: true, foreign_type: "Comment", foreign_key: "event_id"

  validates :event_type, inclusion: { in: NOTIFICATION_TYPES.values }

  def event(eager_loaded = true)
    eager_loaded ? send(NOTIFICATION_CLASS[event_type].underscore) : super()
  end
end
