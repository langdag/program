class User < ApplicationRecord
    has_many :subscriptions
    has_many :partnerships, through: :subscriptions

    has_one_attached :avatar
end
