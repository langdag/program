class User < ApplicationRecord
    has_many :subscriptions
    has_many :partnerships, through: :subscriptions
end
