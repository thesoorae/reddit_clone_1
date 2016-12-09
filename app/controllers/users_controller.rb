class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["invalid username and password"]
      render :new
    end
  end

  def update
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def edit
  end

  def destroy
    User.delete(params[:id])
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
