class Partnership < ApplicationRecord
    has_many :subscriptions
    has_many :users, through: :subscriptions

    has_many_attached :files

    validates_presence_of :title
    validates_length_of :description, :in => 15..1000, :allow_blank => true
end