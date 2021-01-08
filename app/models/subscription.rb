class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :partnership

  scope :not_blocked, -> { where.not(blocked: true)}
end
