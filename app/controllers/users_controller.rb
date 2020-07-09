class UsersController < ApplicationController
  def show

  end

  def new
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.new
  end
  def create
  @user = User.new(user_params)
  if @user.save
    flash[:success] = "wellcom_Hero!"
    redirect_to user_url(@user)
  # Handle a successful save.
  else render :new
    end
  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)

  end

end
