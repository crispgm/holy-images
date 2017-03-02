class Image < ApplicationRecord
  belongs_to :user
  has_many :likes, -> { where status: Like::STATUS_LIKE }

  default_scope do
    order(created_at: :desc)
  end
end
