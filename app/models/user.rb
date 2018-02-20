class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  
  has_many :teams
  has_many :messages
  has_many :talks, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :member_teams, through: :team_users, :source => :team
  has_many :invitations, -> { where approved: false }, class_name: 'Invitation', foreign_key: 'guest_id'
  has_many :inviting, class_name: 'Invitation', foreign_key: 'user_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def my_teams
    self.teams + self.member_teams
  end

  def talk_unread?(team_id, user_id)
    @talk = Talk.find_by(user_one_id: [self.id, user_id], user_two_id: [self.id, user_id], team: team_id)
    @talk.notify_user_id == self.id
  end
end