require "gravtastic"

class User < ApplicationRecord
  has_many :images
  has_many :likes
  # gravatar support
  include Gravtastic
  gravtastic
end
