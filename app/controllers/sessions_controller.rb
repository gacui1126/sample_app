class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) #line 7
    if user.try(:authenticate, params[:session][:password])
      log_in user
      # remember user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'# Not quite right!
      render'new'
    end
  end
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
