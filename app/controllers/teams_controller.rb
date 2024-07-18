class TeamsController < ApplicationController
  before_action :set_team, only: [:edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    return redirect_to(teams_path, alert: @team.errors.full_messages.join(', ')) unless @team.save

    redirect_to teams_path, notice: 'Team was successfully added'
  end

  def edit; end

  def update
    if @team.update(team_params)
      redirect_to request.referer, notice: 'Successfully updated.'
    else
      redirect_to request.referer, notice: 'Could not update team.'
    end
  end

  def destroy
    if @team.destroy
      redirect_to request.referer, notice: 'Successfully deleted.'
    else
      redirect_to request.referer, notice: 'Could not delete team.'
    end
  end

  private

  def set_team
    @team = Team.find_by(id: params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description, :owner_id)
  end
end
