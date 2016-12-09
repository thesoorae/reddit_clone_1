class SubsController < ApplicationController
  before_action :require_login
  def new
    @subreddit = Sub.new
    render :new
  end

  def index
    @subs = Sub.all
    render :index
  end


  def create
    @subreddit = Sub.new(sub_params)
    @subreddit.mod_id = current_user.id
    if @subreddit.save
      redirect_to sub_url(@subreddit)
    else
      flash[:errors] = @subreddit.errors.full_messages
    end
  end

  def show
    @subreddit = Sub.find(params[:id])
    render :show
  end

  def update
    @subreddit = Sub.find(params[:id])
    if @subreddit
      @subreddit.update_attributes(sub_params)
      redirect_to sub_url(@subreddit)
    else
      flash[:errors] = @subreddit.errors.full_messages
      redirect_to sub_url(@subreddit)
    end
  end

  def edit
    @subreddit = Sub.find(params[:id])
    if current_user.id == @subreddit.mod_id
      render :edit
    else
      flash[:errors] = ["Must be a moderator"]
      redirect_to sub_url(@subreddit)
    end
  end

  def destroy
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
