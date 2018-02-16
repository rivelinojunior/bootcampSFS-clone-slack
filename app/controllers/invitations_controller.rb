class InvitationsController < ApplicationController
  before_action :set_team, only: [:create]
  before_action :set_invitation, only: [:update, :destroy]
  before_action :set_guest, only: [:create]

  def index
    @invitations = current_user.invitations
    respond_to do |format|
        format.json { render :index, status: :ok }
    end
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.user_id = @team.user.id
    @invitation.guest_id = @guest.id if @guest
    authorize! :create, @invitation

    respond_to do |format|
      if @invitation.save
        format.json { render :show, status: :created}
      else
        format.json { render json: @invitation.errors, status: :unprocessable_entity}
      end
    end
  end

  def update 
    authorize! :update, @invitation
    @invitation.approved = true
    if @invitation.save
      head :ok
    else
      format.json { render json: @invitation.errors, status: :unprocessable_entity}
    end
  end

  def destroy
    authorize! :destroy, @invitation
    @invitation.destroy
    head :ok
  end

  private
    
    def set_team
      @team = Team.find(params[:invitation][:team_id])
    end

    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    def set_guest
      @guest = User.find_by(email: params[:invitation][:email])
    end

    def invitation_params
      params.require(:invitation).permit(:guest_id, :team_id)
    end 
end