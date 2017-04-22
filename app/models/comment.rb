class Comment < ApplicationRecord
  STATUS_OK = 0

  belongs_to :user
  belongs_to :image

  validates :content, length: {maximum: 140}, presence: true

  default_scope do
    where(status: STATUS_OK)
    order(created_at: :desc)
  end
end
