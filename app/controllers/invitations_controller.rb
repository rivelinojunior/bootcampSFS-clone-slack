class InvitationsController < ApplicationController
  before_action :set_team, only: [:create]

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.user_id = @team.user.id
    authorize! :create, @invitation

    respond_to do |format|
      if @invitation.save
        format.json { render :show, status: :created}
      else
        format.json { render json: @invitation.errors, status: :unprocessable_entity}
      end
    end
  end

  private
    
    def set_team
      @team = Team.find(params[:invitation][:team_id])
    end

    def invitation_params
      params.require(:invitation).permit(:guest_id, :team_id)
    end 
end