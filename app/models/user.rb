class User < ApplicationRecord
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
end