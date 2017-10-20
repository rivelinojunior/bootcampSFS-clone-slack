class TeamsController < ApplicationController
  before_action :set_by_slug_team, only: [:show]
  
  def index
    @teams = current_user.teams
  end

  def show
    authorize! :read, @team
  end

  private
  
  def set_by_slug_team
    @team = Team.find_by(slug: params[:slug])
  end
end