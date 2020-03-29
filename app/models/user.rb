class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :salt, uniqueness: true, presence: true
  validates :verifier, uniqueness: true, presence: true
end
