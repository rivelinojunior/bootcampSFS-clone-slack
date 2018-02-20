class Message < ApplicationRecord
  belongs_to :messagable, polymorphic: true
  belongs_to :user
  validates_presence_of :body, :user

  after_create_commit {MessageBroadcastJob.perform_later self}
  after_create_commit :notify_users
  
  private

    def notify_users
      self.messagable.notify_users = self.messagable.team.my_users.pluck(:id)
      self.messagable.notify_users.delete self.user.id
      self.messagable.save
    end
end