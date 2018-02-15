class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
  after_update :add_guest_with_member_team


  private 
    def add_guest_with_member_team
      if self.approved
        self.team.team_users.create(user_id: self.guest.id)
      end
    end
end
