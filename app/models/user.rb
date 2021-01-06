class User < ApplicationRecord
    has_secure_token :token
    has_secure_password

    has_many :subscriptions
    has_many :partnerships, through: :subscriptions

    validates :email, uniqueness: true, presence: true

    has_one_attached :avatar
end
