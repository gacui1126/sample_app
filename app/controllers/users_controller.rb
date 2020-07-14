class UsersController < ApplicationController

  def show
    @user = User.find_by(params[:id])
    return if @user
    flash[:warning] = "User not found"
    redirect_to root_path
  end

  def new
    @user = User.new
    return if @user
    flash[:warning] = "User not found"
    redirect_to root_pat
  end
  def create
  @user = User.new(user_params)
  if @user.save
    log_in @user
    flash[:success] = "wellcom_Hero!"
    redirect_to @user
  else render :new
    end
  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

end
