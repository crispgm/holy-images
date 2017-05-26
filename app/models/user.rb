require "gravtastic"

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord
  has_many :images
  has_many :likes
  has_many :comments
  has_many :notifications

  validates :name, presence: true, uniqueness: true, on: :create
  validates :email, email: true, uniqueness: true, on: :create
  validates :password, confirmation: true
  
  # gravatar support
  include Gravtastic
  gravtastic
end
