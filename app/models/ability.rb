class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      #Team ---
      can :read, Team do |t|
        t.user_id == user.id || t.users.where(id: user.id).present?
      end

      can :destroy, Team, user_id: user.id

      #Channel ---
      can [:read, :create], Channel do |c|
        c.team.user_id == user.id || c.team.users.where(id: user.id).present?
      end

      can [:destroy, :update], Channel do |c|
        c.team.user_id == user.id || c.user_id == user.id
      end

      #Talk ---
      can [:read], Talk do |t|
        t.user_one_id == user.id || t.user_two_id == user.id
      end

      #TeanUser ---
      can [:create, :destroy], TeamUser do |t|
        t.team.user_id == user.id || t.user_id == user.id
      end

      #Invitation ---
      can [:create], Invitation do |i|
        i.team.user_id == user.id
      end
    end
  end
end
