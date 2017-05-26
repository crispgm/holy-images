class Like < ApplicationRecord
  STATUS_LIKE = 0
  STATUS_UNLIKE = 1

  belongs_to :user
  belongs_to :image

  has_many :notifications, as: :event

  default_scope do
    where(status: STATUS_LIKE)
    order(updated_at: :desc)
  end
end
