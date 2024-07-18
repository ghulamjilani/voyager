class RolesController < ApplicationController
  before_action :set_role, only: [:edit, :update, :destroy]

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)

    return redirect_to(roles_path, alert: @role.errors.full_messages.join(', ')) unless @role.save

    redirect_to roles_path, notice: 'Role was successfully added'
  end

  def edit; end

  def update
    if @role.update(role_params)
      redirect_to request.referer, notice: 'Successfully updated.'
    else
      redirect_to request.referer, notice: 'Could not update role.'
    end
  end

  def destroy
    if @role.destroy
      redirect_to request.referer, notice: 'Successfully deleted.'
    else
      redirect_to request.referer, notice: 'Could not delete role.'
    end
  end

  private

  def set_role
    @role = Role.find_by(id: params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
