class PostsController < ApplicationController
  def new
    @post = Post.new
    @sub_id = params[:sub_id]
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post && @post.author_id == current_user.id
     @post.update_attributes(post_params)
     @post.save
     redirect_to post_url(@post)
   else
     flash[:errors] = @post.errors.full_messages
     redirect_to post_url(@post)
   end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post && @post.author_id == current_user.id
      Post.delete(@post)
      redirect_to posts_url
    else
      flash[:errors] = ["Can't Delete"]
      redirect_to posts_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

end
