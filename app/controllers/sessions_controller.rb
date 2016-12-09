class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])

    if @user
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ['Invalid Login']
      render :new
    end
  end

  def destroy
    # current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
