class AdminsController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?
    redirect_to root_path unless current_user.role?

    @all_user = User.all
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :role)
  end
end
