class MembersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :save_current_team]

  def index
    @users = User.all_users
  end

  def new
    @user = User.new
  end

  def create
    default_password = Devise.friendly_token.first(8)
    @user = User.new(user_params.merge(password: default_password, password_confirmation: default_password))

    return redirect_to(members_path, alert: @user.errors.full_messages.join(', ')) unless @user.save

    @user.add_role(:end_user)
    # @user.invite!
    redirect_to members_path, notice: 'User was successfully added'
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to request.referer, notice: 'Successfully updated.'
    else
      redirect_to request.referer, notice: 'Could not update user.'
    end
  end

  def destroy
    if @user.destroy
      redirect_to request.referer, notice: 'Successfully deleted.'
    else
      redirect_to request.referer, notice: 'Could not delete user.'
    end
  end

  def save_current_team
    @team = Team.find_by(id: params[:team_id])

    if @team && @user.update(current_team_id: @team.id)
      render json: { success: true, data: { user: @user, team: @team } }
    else
      render json: { success: false, error: "Failed to update current team for user" }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :avatar, :password, :password_confirmation)
  end
end
