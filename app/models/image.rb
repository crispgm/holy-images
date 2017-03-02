class Image < ApplicationRecord
  belongs_to :user
  has_many :likes, -> { where status: Like::STATUS_LIKE }
end
