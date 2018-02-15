class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
end
