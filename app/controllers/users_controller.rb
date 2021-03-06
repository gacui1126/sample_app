class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create] #only: [:index, :edit, :update, :destroy]
  before_action :load_user, except: [:index, :create, :new] # only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.actived?.paginate(page: params[:page])
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      # Handle a successful update.
      flash[:success] = "User update success"
      redirect_to users_url
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    else
      flash[:warning] = "co loi xay ra khi xoa user"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = "KHong tim thay user"
    redirect_to root_path
  end
end
