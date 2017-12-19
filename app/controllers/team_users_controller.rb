class TeamUsersController < ApplicationController
  before_action :set_team_user, only: [:destroy]

  def create
  end

  def destroy
    authorize! :destroy, @team_user
    @team_user.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private 

  def set_team_user
    @team_user = TeamUser.find_by(params[:user_id], params[:team_id])
  end
end
