class Partnership < ApplicationRecord
    has_many :subscriptions
    has_many :users, through: :subscriptions

    has_many_attached :files
end