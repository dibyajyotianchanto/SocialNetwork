class Friendship < ApplicationRecord
    validates :sender_id, presence: true
    validates :receiver_id, presence: true
    validates :status, presence: true
end