require "gravtastic"

class User < ApplicationRecord
  has_many :images
  # gravatar support
  include Gravtastic
  gravtastic
end
